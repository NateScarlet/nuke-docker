#!/usr/bin/env python3
"""Update readme by data. """

#pylint: disable=unsubscriptable-object

from itertools import chain
from pathlib import Path

from update_versions import load_versions


def _get_badges_lines():
    last = None
    versions = load_versions()
    versions.reverse()
    for i in versions:
        if last and (i[0] != last[0] or i[1] != last[1]):
            yield "\n"
        tag = f'{i[0]}.{i[1]}v{i[2]}'
        yield (
            f"![{tag}](https://img.shields.io/docker/image-size/"
            f"natescarlet/nuke/{tag}?label={tag})\n"
        )
        last = i
    yield "\n"


def main():
    readme = (Path(__file__).parent.parent / "README.md")
    with readme.open() as f:
        lines = f.readlines()
    try:
        start = lines.index("<!-- image badges start -->\n")
        end = lines.index("<!-- image badges end -->\n")
    except ValueError:
        raise ValueError("image badges inject marker is missing")

    with readme.open("w") as f:
        try:
            f.writelines(chain(
                lines[:start + 1],
                ["\n"],
                _get_badges_lines(),
                lines[end:],
            ))
        except Exception as ex:
            f.writelines(lines)
            raise ex


if __name__ == '__main__':
    main()
