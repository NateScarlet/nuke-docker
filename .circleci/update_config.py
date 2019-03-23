#!/usr/bin/env python3
"""Generate circle ci config.  """

import logging
from multiprocessing.dummy import Pool
from pathlib import Path

import requests

CONFIG_TEMPLATE = '''\
version: 2.1
orbs:
  docker-publish: circleci/docker-publish@0.1.6
executors:
  docker: docker-publish/docker
commands:
  publish:
    parameters:
      major:
        type: integer
      minor:
        type: integer
      patch:
        type: integer
    steps:
      - checkout
      - setup_remote_docker
      - docker-publish/check
      - docker-publish/build:
          extra_build_args: >-
            --build-arg DEBIAN_MIRROR=
            --build-arg foundry_LICENSE=
            --build-arg NUKE_MAJOR=<< parameters.major >>
            --build-arg NUKE_MINOR=<< parameters.minor >>
            --build-arg NUKE_PATCH=<< parameters.patch >>
          image: natescarlet/nuke
          tag: << parameters.major >>.<< parameters.minor >>v<< parameters.patch >>
      - docker-publish/deploy:
          image: natescarlet/nuke
'''


def version_range(start: list, end: list):
    """Generator for version range. """

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


def get_versions():
    """Get avaliable nuke versions.  """

    ret = set()

    def add_if_downloadable(i):
        if is_downloadable(*i):
            ret.add(i)
    pool = Pool()
    pool.map_async(add_if_downloadable,
                   version_range([9, 0, 1], [12, 10, 10]))
    pool.close()
    pool.join()

    return sorted(ret)


LOGGER = logging.getLogger(__name__)


def is_downloadable(major: int, minor: int, patch: int) -> bool:
    """Test whether is a downloadable nuke version.

    Args:
        major (int): Major version
        minor (int): Minor version
        patch (int): Patch version

    Returns:
        bool: Test result
    """

    version = f'{major}.{minor}v{patch}'
    url = ('https://thefoundry.s3.amazonaws.com/'
           f'products/nuke/releases/{version}/Nuke{version}-linux-x86-release-64.tgz')
    LOGGER.debug('testing download: %s', version)
    resp = requests.head(url, timeout=3)

    return resp.status_code == 200


def generate_config():
    """Config generator.  """

    yield CONFIG_TEMPLATE
    yield '''\
jobs:
'''

    jobs = []
    for i in get_versions():
        jobname = f'publish-{i[0]}-{i[1]}-{i[2]}'
        jobs.append(jobname)
        yield f'''\
  {jobname}:
    executor: docker
    steps:
      - publish:
          major: {i[0]}
          minor: {i[1]}
          patch: {i[2]}
'''

    yield '''\
workflows:
  version: 2
  build and publish:
    jobs:
'''

    for i in jobs:
        yield f'''\
      - {i}
'''


def main():
    logging.basicConfig(level=logging.DEBUG)
    with (Path(__file__).parent / 'config.yml').open('w', encoding='utf-8') as f:
        for i in generate_config():
            f.write(i)


if __name__ == '__main__':
    main()
