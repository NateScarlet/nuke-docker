# https://www.foundry.com/products/nuke/requirements
FROM centos:7 AS install

# Example: https://mirrors.aliyun.com/pypi/simple
ARG PIP_INDEX_URL
RUN set -ex ;\
    yum -y install \
        # nuke common requires
        xorg-x11-server-Xvfb \
        xorg-x11-server-utils \
        alsa-lib \
        mesa-libGLU \
        # utils
        unzip \
        gettext \
        sudo \
        ;\
    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py | python ;\
    pip install -U --no-cache-dir virtualenv ;\
    yum -y clean all ;\
    rm -rf /var/cache ;\
    useradd -rmU -s /bin/bash nuke ;\
    echo "nuke ALL=(ALL) NOPASSWD:ALL" | (EDITOR='tee -a' visudo) ;

ARG NUKE_MAJOR=10
ARG NUKE_MINOR=5
ARG NUKE_PATCH=8

ENV NUKE_MAJOR=${NUKE_MAJOR}
ENV NUKE_MINOR=${NUKE_MINOR}
ENV NUKE_PATCH=${NUKE_PATCH}
ENV NUKE_VERSION=${NUKE_MAJOR}.${NUKE_MINOR}v${NUKE_PATCH}

RUN set -ex ;\
    if [ "${NUKE_MAJOR}" == 13 ]; then \
        yum -y install \
            libXv \
        ;\
    fi ;\
    if [ "${NUKE_MAJOR}" == 12 ]; then \
        yum -y install \
            libXv \
        ;\
    fi ;\
    if [ "${NUKE_MAJOR}" == 11 ]; then \
        yum -y install \
            libXft \
            pulseaudio-libs \
            libfontconfig \
            libXcomposite \
            libXtst \
        ;\
    fi ;\
    if [ "${NUKE_MAJOR}" == 10 ]; then \
        yum -y install \
            libXft \
            libfontconfig \
        ;\
    fi ;\
    if [ "${NUKE_MAJOR}" == 9 ]; then \
        yum -y install \
            libXft \
            libXv \
            libfontconfig \
            SDL \
            libpng12 \
        ;\
    fi ;\
    yum -y clean all ;\
    rm -rf /var/cache ;

WORKDIR /usr/local/Nuke${NUKE_VERSION}
ARG NUKE_DOWNLOAD_URL=https://thefoundry.s3.amazonaws.com/products/nuke/releases/${NUKE_VERSION}/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz
ARG NUKE_FILE_EXCLUDE="Documentation plugins/OCIOConfigs/configs/aces_* plugins/caravr"
RUN set -ex ;\
    mkdir -p /tmp/Nuke/ ;\
    curl -o /tmp/Nuke/Nuke${NUKE_VERSION}.tgz $(echo ${NUKE_DOWNLOAD_URL} | envsubst) ;\
    tar -C /tmp/Nuke/ -xvzf /tmp/Nuke/Nuke${NUKE_VERSION}.tgz ;\
    if [ -e "/tmp/Nuke/Nuke${NUKE_VERSION}-linux-x86-release-64-installer" ]; then \
        unzip /tmp/Nuke/Nuke${NUKE_VERSION}-linux-x86-release-64-installer ;\
    else \
        `ls /tmp/Nuke/Nuke*.run` --prefix=.. --accept-foundry-eula ;\
    fi &&\
    rm -rf /tmp/Nuke ;\
    if [ -n "${NUKE_FILE_EXCLUDE}" ];then \
        rm -rfv ${NUKE_FILE_EXCLUDE} ;\
    fi ;\
    LD_LIBRARY_PATH=`pwd` ldd Nuke* libstudio* | (set +e; grep 'not found'; case $? in 0) exit 1;; 1) exit 0;; *) exit $?;; esac;) ;\
    ln -s `pwd`/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke ;\
    ln -s `pwd`/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke${NUKE_MAJOR} ;\
    ln -s `pwd`/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke${NUKE_MAJOR}.${NUKE_MINOR} ;\
    # only allow root to write
    chmod -R go-w . ;\
    if [ -e "python" ]; then \
        ln -s python py ;\
        # fix permission issue for 9.0v9
        chmod +x python python2 python2.7 ;\
    elif [ -e "python3" ]; then \
        ln -s python3 py ;\
    else \
        ls ;\ 
        echo "python not found" && exit 1;\
    fi;

ENV NUKE_PYTHON=/usr/local/Nuke${NUKE_VERSION}/py

WORKDIR /home/nuke
USER nuke

FROM install AS test

RUN python --version
RUN pip --version
RUN Nuke --version
RUN virtualenv --version
RUN ${NUKE_PYTHON} --version
# Example: 5053@10.0.2.2
ARG foundry_LICENSE
RUN if [ -n "${foundry_LICENSE}" ];then \
        ${NUKE_PYTHON} -c 'import nuke; print(nuke.NUKE_VERSION_STRING)' ;\
    fi
RUN sudo echo testing_sudo

FROM install AS release

LABEL author='NateScarlet@Gmail.com'
CMD ["Nuke", "-t"]
