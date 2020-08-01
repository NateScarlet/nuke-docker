FROM buildpack-deps:stable AS base

RUN set -e
ENV LC_ALL=C.UTF-8

ARG NUKE_MAJOR=10
ARG NUKE_MINOR=5
ARG NUKE_PATCH=8

ENV DEBIAN_FRONTEND=noninteractive
ENV NUKE_MAJOR=${NUKE_MAJOR}
ENV NUKE_MINOR=${NUKE_MINOR}
ENV NUKE_PATCH=${NUKE_PATCH}
ENV NUKE_VERSION=${NUKE_MAJOR}.${NUKE_MINOR}v${NUKE_PATCH}

FROM base AS install

ARG DEBIAN_MIRROR
RUN if [ -n "$DEBIAN_MIRROR" ]; then \
    sed -i "s@http://.\+\.debian\.org/debian@$DEBIAN_MIRROR@g" /etc/apt/sources.list \
    && cat /etc/apt/sources.list; \
    fi
RUN apt-get update &&\
    apt-get -y install \
    x11-apps x11vnc \
    libglu1-mesa libglib2.0-0 libsdl1.2debian libgl1-mesa-glx \
    sudo python-pip

ARG PIP_INDEX_URL
RUN pip install -U --no-cache-dir virtualenv pip

WORKDIR /usr/local/share/the-foundry/Nuke${NUKE_VERSION}
RUN mkdir -p /tmp/Nuke/installer &&\
    wget -P /tmp/Nuke \
    https://thefoundry.s3.amazonaws.com/products/nuke/releases/${NUKE_VERSION}/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz &&\
    tar -C /tmp/Nuke/installer -xvzf /tmp/Nuke/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz &&\
    if [ -e "/tmp/Nuke/installer/Nuke${NUKE_VERSION}-linux-x86-release-64-installer" ]; then \
        unzip /tmp/Nuke/installer/Nuke${NUKE_VERSION}-linux-x86-release-64-installer; \
    else \
        $(ls /tmp/Nuke/installer/Nuke*-installer.run) --accept-foundry-eula; \
    fi &&\
    rm -rf /tmp/Nuke

RUN useradd -rmU -s /bin/bash nuke &&\
    echo "nuke ALL=(ALL) NOPASSWD:ALL" | (EDITOR='tee -a' visudo)
RUN ln -s Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke
RUN ln -s Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke${NUKE_MAJOR}
RUN ln -s Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke${NUKE_MAJOR}.${NUKE_MINOR}

USER nuke
WORKDIR /home/nuke

ARG foundry_LICENSE=5053@10.0.2.2

FROM install AS test

RUN python --version
RUN pip --version
RUN virtualenv --python python .venv
RUN if [ ! -z ${foundry_LICENSE} ];then\
    python -c 'import nuke; print(nuke.NUKE_VERSION_STRING)' &&\
    Nuke --version;\
    fi
RUN sudo echo testing_sudo

FROM install AS release

RUN set +e

ENV DEBIAN_FRONTEND=
LABEL author='NateScarlet@Gmail.com'

CMD ["Nuke", "-t"]
