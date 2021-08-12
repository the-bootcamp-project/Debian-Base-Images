FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install -y --no-install-recommends apt-utils && \
    apt upgrade -y && apt install -y \
        build-essential gcc make cmake \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        zip wget curl git git-flow sudo util-linux

RUN apt autoremove -y

RUN adduser --disabled-password --gecos '' bootcamp && \
    adduser bootcamp sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chown -R bootcamp /home/bootcamp

RUN mkdir -p /tmp/semver/ && \
    git clone https://github.com/fsaintjacques/semver-tool.git /tmp/semver/ && \
    cp -r /tmp/semver/src/ /usr/local/bin/ && \
    chmod +x bootcamp:bootcamp /usr/local/bin/semver

USER bootcamp

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:/usr/local/bin/python3:/usr/local/bin/pip3:$PATH

WORKDIR /home/bootcamp

# tbcp/debian:latest
