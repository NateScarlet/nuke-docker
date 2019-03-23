# nuke-docker

The foundry nuke in docker container

- [x] Can be use as nuke plugin test environment

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

Use environment variable `foundry_LICENSE` to specify license (or mount your FLEXlm license with `-v <your license path>:/usr/local/foundry/FLEXlm`)

```shell
docker run -it --rm -e foundry_LICENSE=<your license server> natescarlet/nuke:11.3v2
```

#### FLEXlm

```shell
docker run -it --rm -e -v <your license path>:/usr/local/foundry/FLEXlm natescarlet/nuke:11.3v2
```

### Build your self

For nuke 10.5v2

```shell
docker build --build-arg NUKE_MAJOR=10 --build-arg NUKE_MINOR=5 --build-arg NUKE_PATCH=2 --tag natesarlet/nuke:10.5v2 .
```
