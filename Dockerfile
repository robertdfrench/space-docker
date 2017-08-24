FROM fedora:26

LABEL version="0.1"

RUN dnf install -y tar wget python @development-tools
RUN dnf install -y which
RUN dnf install -y e2fsprogs
RUN wget https://github.com/singularityware/singularity/releases/download/2.3.1/singularity-2.3.1.tar.gz && \
    tar xzf singularity-2.3.1.tar.gz && \
    cd singularity-2.3.1/ && \
    ./configure && make && make install

VOLUME ["/Users/rf9/Projects/space-docker/shared", "/dev"]
