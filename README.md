# nuke-docker

[![Build Status](https://img.shields.io/circleci/project/github/NateScarlet/nuke-docker.svg)](https://circleci.com/gh/NateScarlet/nuke-docker)
![Maintenance](https://img.shields.io/maintenance/yes/2019.svg)

[GitHub](https://github.com/NateScarlet/nuke-docker)

[Docker Hub](https://hub.docker.com/r/natescarlet/nuke)

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

## Prebuilt images

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v1.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v1.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v2.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v2.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v3.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v3.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v4.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v4.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v5.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v5.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v6.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v6.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v7.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v7.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v8.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v8.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:9.0v9.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:9.0v9.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.0v1.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.0v1.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.0v2.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.0v2.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.0v3.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.0v3.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.0v4.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.0v4.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.0v5.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.0v5.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.0v6.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.0v6.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v1.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v1.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v2.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v2.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v3.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v3.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v4.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v4.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v5.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v5.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v6.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v6.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v7.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v7.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:10.5v8.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:10.5v8.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.0v1.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.0v1.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.0v2.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.0v2.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.0v3.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.0v3.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.0v4.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.0v4.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.1v1.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.1v1.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.1v2.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.1v2.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.1v3.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.1v3.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.1v4.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.1v4.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.1v5.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.1v5.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.1v6.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.1v6.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.2v1.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.2v1.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.2v2.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.2v2.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.2v3.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.2v3.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.2v4.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.2v4.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.2v5.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.2v5.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.2v6.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.2v6.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.3v1.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.3v1.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.3v2.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.3v2.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.3v3.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.3v3.svg)

![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:11.3v4.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:11.3v4.svg)
