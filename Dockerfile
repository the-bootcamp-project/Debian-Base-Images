FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install -y --no-install-recommends apt-utils && \
    apt upgrade -y && apt install -y \
        build-essential gcc make cmake \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        zip wget curl git git-flow sudo util-linux file \
        shellcheck

RUN apt autoremove -y

RUN adduser --disabled-password --gecos '' bootcamp && \
    adduser bootcamp sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chown -R bootcamp /home/bootcamp

USER bootcamp

WORKDIR /home/bootcamp

RUN git clone https://github.com/fsaintjacques/semver-tool.git && \
    sudo cp -r ~/semver-tool/src/semver /usr/local/bin/ && \
    rm -r ~/semver-tool && \
    semver --version

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:/usr/local/bin/python3:/usr/local/bin/pip3:$PATH

# tbcp/debian:latest
