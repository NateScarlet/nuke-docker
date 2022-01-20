#!/usr/bin/env python3
"""Generate version data.  """

import itertools
import time
from typing import Set, Text, Tuple
import gevent.monkey

gevent.monkey.patch_all()

# pylint:disable=using-constant-test
if True:
    import json
    import logging
    from pathlib import Path

    import gevent
    import requests
    from gevent.pool import Pool

_LOGGER = logging.getLogger(__name__)


def version_range(start: list, end: list):
    """Generator for version range."""

    current = list(start)
    while True:
        yield tuple(current)
        if current[2] < end[2]:
            current[2] += 1
        elif current[1] < end[1]:
            current[1] += 1
            current[2] = 1
        elif current[0] < end[0]:
            current[0] += 1
            current[1] = 0
            current[2] = 1
        else:
            return


def _url1(major: int, minor: int, patch: int) -> Text:
    version = f"{major}.{minor}v{patch}"
    return (
        "https://thefoundry.s3.amazonaws.com/"
        f"products/nuke/releases/{version}/Nuke{version}-linux-x86-release-64.tgz"
    )


def _url2(version: Tuple[int, int, int]) -> Text:
    major, minor, patch = version
    versionText = f"{major}.{minor}v{patch}"
    return f"https://thefoundry.s3.amazonaws.com/products/nuke/releases/{versionText}/Nuke{versionText}-linux-x86_64.tgz"


def _url3(version: Tuple[int, int, int]) -> Text:
    major, minor, patch = version
    versionText = f"{major}.{minor}v{patch}"
    return f"https://www.foundry.com/products/download_product?file=Nuke{versionText}-linux-x86_64.tgz"


class Release:
    def __init__(self):
        self.version = (0, 0, 0)
        self.url = ""

    def __str__(self):
        major, minor, patch = self.version
        return f"{major}.{minor}v{patch}"

    def __repr__(self) -> str:
        return f"Release<{self.__str__()}>"

    def from_version(self, version: Tuple[int, int, int]):
        self.version = version
        major, minor, patch = version
        self.url = _url1(major, minor, patch)

    def from_dict(self, v: dict):
        self.version = tuple(v["version"])
        self.url = v["url"]

    def to_dict(self) -> dict:
        return dict(
            version=self.version,
            url=self.url,
        )

    def is_downloadable(self) -> bool:
        """Test whether is a downloadable nuke version.

        Args:
            major (int): Major version
            minor (int): Minor version
            patch (int): Patch version

        Returns:
            bool: Test result
        """

        _LOGGER.debug("testing download url: %s", self.url)
        try:
            resp = requests.head(self.url)
            return resp.status_code == 200
        except:
            return False

    def future_releases(self):
        major, minor, patch = self.version
        for version in itertools.chain(
            (
                (major, minor, patch + 1),
                (major, minor, patch + 2),
                (major, minor, patch + 3),
                (major, minor + 1, 1),
                (major, minor + 2, 1),
                (major, minor + 3, 1),
                (major, minor + 4, 1),
                (major, minor + 5, 1),
                (major, minor + 6, 1),
                (major, minor + 7, 1),
                (major + 1, 0, 1),
            ),
            itertools.product(
                range(major + 1, major + 2),
                range(0, 9),
                range(1, 10),
            ),
        ):
            r = Release()
            r.version = version
            r.url = _url2(version)
            yield r


def load_releases():
    """load versions data from versions.json"""

    with (Path(__file__).parent.parent / "versions.json").open() as f:
        data = json.load(f)
        for i in data["versions"]:
            r = Release()
            if isinstance(i, list):
                r.from_version(tuple(i))
            else:
                r.from_dict(i)
            yield r


def get_releases():
    """Get avaliable nuke versions."""

    releases = set(load_releases())

    latest_major = max(i.version[0] for i in releases)
    versions = set(i.version for i in releases)

    future_releases = set(
        {
            j.version: j
            for i in releases
            for j in i.future_releases()
            if j.version not in versions
        }.values()
    )

    def _is_prev_version_downloadable(release: Release):
        major, minor, patch = release.version
        return (major, minor, patch - 1) in versions

    future_releases = set(
        i
        for i in future_releases
        if (i.version[0] > latest_major - 2) or _is_prev_version_downloadable(i)
    )

    new_releases: Set[Release] = set()

    def add_if_downloadable(release: Release):
        if release.is_downloadable():
            new_releases.add(release)

    _LOGGER.debug(
        "test future releases: %s",
        sorted(i.version for i in future_releases),
    )

    pool = Pool(32)
    pool.map(add_if_downloadable, sorted(future_releases, key=lambda x: x.version))
    pool.join()

    for i in new_releases:
        _LOGGER.info("found new release: %s", i.version)

    return sorted(releases.union(new_releases), key=lambda x: x.version)


def main():
    data = {
        "$comment": "Code generated by ./scripts/update_versions.py, DO NOT EDIT.",
        "versions": [i.to_dict() for i in get_releases()],
    }
    with (Path(__file__).parent.parent / "versions.json").open("w") as f:
        json.dump(data, f, indent=2)


if __name__ == "__main__":
    logging.basicConfig()
    _LOGGER.setLevel(logging.DEBUG)
    main()
