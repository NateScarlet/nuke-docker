# https://www.foundry.com/products/nuke/requirements
FROM centos:7 AS install

# Example: https://mirrors.aliyun.com/pypi/simple
ARG PIP_INDEX_URL
RUN set -ex ;\
    yum -y groupinstall x11 ;\
    yum -y install \
        mesa-libGLU \
        unzip \
        gettext \
        sudo \
        ; \
    curl https://bootstrap.pypa.io/2.7/get-pip.py | python ;\
    pip install -U --no-cache-dir virtualenv ;\
    yum -y clean all ;\
    rm -rf /var/cache ;\
    useradd -rmU -s /bin/bash nuke ;\
    echo "nuke ALL=(ALL) NOPASSWD:ALL" | (EDITOR='tee -a' visudo) ;

ARG NUKE_MAJOR=10
ARG NUKE_MINOR=5
ARG NUKE_PATCH=8

RUN set -ex ;\
    if [ "${NUKE_MAJOR}" == 9 ]; then \
        yum -y install SDL ;\
        yum -y clean all ;\
        rm -rf /var/cache ;\
    fi

ENV NUKE_MAJOR=${NUKE_MAJOR}
ENV NUKE_MINOR=${NUKE_MINOR}
ENV NUKE_PATCH=${NUKE_PATCH}
ENV NUKE_VERSION=${NUKE_MAJOR}.${NUKE_MINOR}v${NUKE_PATCH}

WORKDIR /usr/local/Nuke${NUKE_VERSION}
ARG NUKE_DOWNLOAD_URL=https://thefoundry.s3.amazonaws.com/products/nuke/releases/${NUKE_VERSION}/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz
RUN set -ex ;\
    mkdir -p /tmp/Nuke/ ;\
    curl -o /tmp/Nuke/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz $(echo ${NUKE_DOWNLOAD_URL} | envsubst) ;\
    tar -C /tmp/Nuke/ -xvzf /tmp/Nuke/Nuke${NUKE_VERSION}-linux-x86-release-64.tgz ;\
    if [ -e "/tmp/Nuke/Nuke${NUKE_VERSION}-linux-x86-release-64-installer" ]; then \
        unzip /tmp/Nuke/Nuke${NUKE_VERSION}-linux-x86-release-64-installer ;\
    else \
        $(ls /tmp/Nuke/Nuke*-installer.run) --prefix=.. --accept-foundry-eula ;\
    fi &&\
    rm -rf /tmp/Nuke &&\
    ln -s $(pwd)/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke ;\
    ln -s $(pwd)/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke${NUKE_MAJOR} ;\
    ln -s $(pwd)/Nuke${NUKE_MAJOR}.${NUKE_MINOR} /usr/local/bin/Nuke${NUKE_MAJOR}.${NUKE_MINOR}
ENV NUKE_PYTHON=/usr/local/Nuke${NUKE_VERSION}/python

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
