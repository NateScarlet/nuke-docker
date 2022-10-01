# nuke-docker

[![Nuke Versions Update Status](https://github.com/NateScarlet/nuke-docker/workflows/update-nuke-versions/badge.svg)](https://github.com/NateScarlet/nuke-docker/actions?query=workflow%3Aupdate-nuke-versions)
[![Build Status](https://img.shields.io/circleci/project/github/NateScarlet/nuke-docker)](https://circleci.com/gh/NateScarlet/nuke-docker)
![Latest Nuke Version](https://img.shields.io/docker/v/natescarlet/nuke?label=latest%20nuke%20version&sort=semver)
![Docker Starts](https://img.shields.io/docker/stars/natescarlet/nuke)
![Docker Pulls](https://img.shields.io/docker/pulls/natescarlet/nuke)
![Maintenance](https://img.shields.io/maintenance/yes/2022.svg)

[GitHub](https://github.com/NateScarlet/nuke-docker)

[Docker Hub](https://hub.docker.com/r/natescarlet/nuke)

The foundry nuke in docker container

- [x] Can be use as nuke plugin test environment: [example](https://github.com/WuLiFang/Nuke/blob/69239d67ba8b5457c949ce29a5362711c242ac4a/.drone.yml)
- [x] Exclude files that usually not necessary for container to reduce image size (Documentation, OCIOConfig, large plugins, optional libraries).
- [x] Prebuilt images for all nuke versions that downloadable from official site.

## Usage

```shell
> docker run -it --rm -e foundry_LICENSE=5053@10.0.2.2 natescarlet/nuke:10.5v7
Nuke 10.5v7, 64 bit, built Nov 14 2017.
Copyright (c) 2017 The Foundry Visionmongers Ltd.  All Rights Reserved.
>>> import nuke
>>> nuke.NUKE_VERSION_STRING
'10.5v7'
>>> nuke.createNode('Constant')
<Constant1 at 0x2781570>
>>>
```

### Setup license

#### RLM

Use environment variable `foundry_LICENSE` to specify license server

```shell
docker run -it --rm -e foundry_LICENSE=<your license server> natescarlet/nuke:11.3v2
```

#### FLEXlm

Mount your FLEXlm license file

```shell
docker run -it --rm -e -v <your license path>:/usr/local/foundry/FLEXlm natescarlet/nuke:11.3v2
```

### Build yourself

For nuke 10.5v2

```shell
docker build --build-arg NUKE_MAJOR=10 --build-arg NUKE_MINOR=5 --build-arg NUKE_PATCH=2 --tag natescarlet/nuke:10.5v2 .
```

## Prebuilt images

New nuke version will be auto added by CI on the 1st of every month.

tags:

- latest: `latest`

- major: `9`, `10`, `11`, `12`

- minor: `9.0`, `10.0`, `10.5`, ...

- patch: `9.0v1`, `9.0v2`, `9.0v3`, ...

<!-- image badges start -->

![13.2v4](https://img.shields.io/docker/image-size/natescarlet/nuke/13.2v4?label=13.2v4)
![13.2v3](https://img.shields.io/docker/image-size/natescarlet/nuke/13.2v3?label=13.2v3)
![13.2v2](https://img.shields.io/docker/image-size/natescarlet/nuke/13.2v2?label=13.2v2)
![13.2v1](https://img.shields.io/docker/image-size/natescarlet/nuke/13.2v1?label=13.2v1)

![13.1v5](https://img.shields.io/docker/image-size/natescarlet/nuke/13.1v5?label=13.1v5)
![13.1v4](https://img.shields.io/docker/image-size/natescarlet/nuke/13.1v4?label=13.1v4)
![13.1v3](https://img.shields.io/docker/image-size/natescarlet/nuke/13.1v3?label=13.1v3)
![13.1v2](https://img.shields.io/docker/image-size/natescarlet/nuke/13.1v2?label=13.1v2)
![13.1v1](https://img.shields.io/docker/image-size/natescarlet/nuke/13.1v1?label=13.1v1)

![13.0v10](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v10?label=13.0v10)
![13.0v9](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v9?label=13.0v9)
![13.0v8](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v8?label=13.0v8)
![13.0v7](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v7?label=13.0v7)
![13.0v6](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v6?label=13.0v6)
![13.0v5](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v5?label=13.0v5)
![13.0v4](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v4?label=13.0v4)
![13.0v3](https://img.shields.io/docker/image-size/natescarlet/nuke/13.0v3?label=13.0v3)

![12.2v11](https://img.shields.io/docker/image-size/natescarlet/nuke/12.2v11?label=12.2v11)
![12.2v10](https://img.shields.io/docker/image-size/natescarlet/nuke/12.2v10?label=12.2v10)
![12.2v9](https://img.shields.io/docker/image-size/natescarlet/nuke/12.2v9?label=12.2v9)
![12.2v8](https://img.shields.io/docker/image-size/natescarlet/nuke/12.2v8?label=12.2v8)
![12.2v7](https://img.shields.io/docker/image-size/natescarlet/nuke/12.2v7?label=12.2v7)

![12.0v1](https://img.shields.io/docker/image-size/natescarlet/nuke/12.0v1?label=12.0v1)

![11.3v6](https://img.shields.io/docker/image-size/natescarlet/nuke/11.3v6?label=11.3v6)
![11.3v5](https://img.shields.io/docker/image-size/natescarlet/nuke/11.3v5?label=11.3v5)
![11.3v4](https://img.shields.io/docker/image-size/natescarlet/nuke/11.3v4?label=11.3v4)
![11.3v3](https://img.shields.io/docker/image-size/natescarlet/nuke/11.3v3?label=11.3v3)
![11.3v2](https://img.shields.io/docker/image-size/natescarlet/nuke/11.3v2?label=11.3v2)
![11.3v1](https://img.shields.io/docker/image-size/natescarlet/nuke/11.3v1?label=11.3v1)

![11.2v7](https://img.shields.io/docker/image-size/natescarlet/nuke/11.2v7?label=11.2v7)
![11.2v6](https://img.shields.io/docker/image-size/natescarlet/nuke/11.2v6?label=11.2v6)
![11.2v5](https://img.shields.io/docker/image-size/natescarlet/nuke/11.2v5?label=11.2v5)
![11.2v4](https://img.shields.io/docker/image-size/natescarlet/nuke/11.2v4?label=11.2v4)
![11.2v3](https://img.shields.io/docker/image-size/natescarlet/nuke/11.2v3?label=11.2v3)
![11.2v2](https://img.shields.io/docker/image-size/natescarlet/nuke/11.2v2?label=11.2v2)
![11.2v1](https://img.shields.io/docker/image-size/natescarlet/nuke/11.2v1?label=11.2v1)

![11.1v6](https://img.shields.io/docker/image-size/natescarlet/nuke/11.1v6?label=11.1v6)
![11.1v5](https://img.shields.io/docker/image-size/natescarlet/nuke/11.1v5?label=11.1v5)
![11.1v4](https://img.shields.io/docker/image-size/natescarlet/nuke/11.1v4?label=11.1v4)
![11.1v3](https://img.shields.io/docker/image-size/natescarlet/nuke/11.1v3?label=11.1v3)
![11.1v2](https://img.shields.io/docker/image-size/natescarlet/nuke/11.1v2?label=11.1v2)
![11.1v1](https://img.shields.io/docker/image-size/natescarlet/nuke/11.1v1?label=11.1v1)

![11.0v4](https://img.shields.io/docker/image-size/natescarlet/nuke/11.0v4?label=11.0v4)
![11.0v3](https://img.shields.io/docker/image-size/natescarlet/nuke/11.0v3?label=11.0v3)
![11.0v2](https://img.shields.io/docker/image-size/natescarlet/nuke/11.0v2?label=11.0v2)
![11.0v1](https://img.shields.io/docker/image-size/natescarlet/nuke/11.0v1?label=11.0v1)

![10.5v8](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v8?label=10.5v8)
![10.5v7](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v7?label=10.5v7)
![10.5v6](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v6?label=10.5v6)
![10.5v5](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v5?label=10.5v5)
![10.5v4](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v4?label=10.5v4)
![10.5v3](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v3?label=10.5v3)
![10.5v2](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v2?label=10.5v2)
![10.5v1](https://img.shields.io/docker/image-size/natescarlet/nuke/10.5v1?label=10.5v1)

![10.0v6](https://img.shields.io/docker/image-size/natescarlet/nuke/10.0v6?label=10.0v6)
![10.0v5](https://img.shields.io/docker/image-size/natescarlet/nuke/10.0v5?label=10.0v5)
![10.0v4](https://img.shields.io/docker/image-size/natescarlet/nuke/10.0v4?label=10.0v4)
![10.0v3](https://img.shields.io/docker/image-size/natescarlet/nuke/10.0v3?label=10.0v3)
![10.0v2](https://img.shields.io/docker/image-size/natescarlet/nuke/10.0v2?label=10.0v2)
![10.0v1](https://img.shields.io/docker/image-size/natescarlet/nuke/10.0v1?label=10.0v1)

![9.0v9](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v9?label=9.0v9)
![9.0v8](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v8?label=9.0v8)
![9.0v7](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v7?label=9.0v7)
![9.0v6](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v6?label=9.0v6)
![9.0v5](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v5?label=9.0v5)
![9.0v4](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v4?label=9.0v4)
![9.0v3](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v3?label=9.0v3)
![9.0v2](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v2?label=9.0v2)
![9.0v1](https://img.shields.io/docker/image-size/natescarlet/nuke/9.0v1?label=9.0v1)

<!-- image badges end -->
