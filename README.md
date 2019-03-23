# nuke-docker

[![Build Status](https://img.shields.io/circleci/project/github/NateScarlet/nuke-docker.svg)](https://circleci.com/gh/NateScarlet/nuke-docker)
![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)

[Docker Hub Page](https://hub.docker.com/r/natescarlet/nuke/tags)

The foundry nuke in docker container

- [x] Can be use as nuke plugin test environment
- [x] Prebuilt images for all nuke versions that downloadable from official site

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
docker build --build-arg NUKE_MAJOR=10 --build-arg NUKE_MINOR=5 --build-arg NUKE_PATCH=2 --tag natesarlet/nuke:10.5v2 .
```
