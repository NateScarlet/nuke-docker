FROM buildpack-deps:stable AS base

RUN set +e

ARG NUKE_MAJOR=10
ARG NUKE_MINOR=5
ARG NUKE_PATCH=8

ENV DEBIAN_FRONTEND=noninteractive
ENV NUKE_MAJOR=${NUKE_MAJOR}
ENV NUKE_MINOR=${NUKE_MINOR}
ENV NUKE_PATCH=${NUKE_PATCH}
ENV NUKE_VERSION=${NUKE_MAJOR}.${NUKE_MINOR}v${NUKE_PATCH}

FROM base as download

WORKDIR /app
RUN wget -P /tmp/ \
    https://thefoundry.s3.amazonaws.com/products/nuke/releases/${NUKE_VERSION}/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz &&\
    tar -C /tmp -xvzf /tmp/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz &&\
    unzip /tmp/Nuke${NUKE_VERSION}-linux-x86-release-64-installer -d Nuke${NUKE_VERSION} &&\
    rm -vf /tmp/*

FROM base AS install

ARG DEBIAN_MIRROR=http://mirrors.huaweicloud.com/debian
RUN if [ ! -z $DEBIAN_MIRROR ]; then \
    sed -i "s@http://.\+\.debian\.org/debian@$DEBIAN_MIRROR@g" /etc/apt/sources.list \
    && cat /etc/apt/sources.list; \
    fi

ARG PIP_INDEX_URL=https://mirrors.huaweicloud.com/repository/pypi/simple
RUN apt-get update &&\
    apt-get -y install \
    x11-apps x11vnc \
    libglu1-mesa libglib2.0-0 libsdl1.2debian libgl1-mesa-glx \
    sudo python-pip
RUN pip install -U --no-cache-dir virtualenv pip

COPY --from=download /app/ /app/

RUN useradd -rmU -s /bin/bash nuke &&\
    chown nuke:nuke /app/Nuke${NUKE_VERSION} &&\
    echo "nuke ALL=(ALL) NOPASSWD:ALL" | (EDITOR='tee -a' visudo)
USER nuke
WORKDIR /home/nuke

USER root
RUN ln -s /app/Nuke${NUKE_VERSION}/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke
RUN ln -s /app/Nuke${NUKE_VERSION}/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke${NUKE_MAJOR}.${NUKE_MINOR}
USER nuke

ENV PATH=/app/Nuke${NUKE_VERSION}:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/nuke/.local/bin

ARG foundry_LICENSE=5053@10.0.2.2
ENV foundry_LICENSE=${foundry_LICENSE}

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

RUN set -e

ENV DEBIAN_FRONTEND=
LABEL author='NateScarlet@Gmail.com'

CMD ["Nuke", "-t"]
