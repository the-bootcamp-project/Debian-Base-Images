FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt clean 2>/dev/null && \
    apt update 2>/dev/null | grep packages | cut -d '.' -f 1 && \
    DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends apt-utils locales

RUN locale-gen en_US.utf8

ENV LANG en_US.utf8
ENV LANGUAGE en_US.utf8
ENV LC_CTYPE en_US.utf8

RUN apt upgrade -y 2>/dev/null | grep packages | cut -d '.' -f 1 && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        build-essential gcc shc make cmake \
        libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
        zip wget curl nano git git-flow sudo util-linux file \
        shellcheck 2>/dev/null | grep packages | cut -d '.' -f 1


RUN apt autoremove -y 2>/dev/null | grep packages | cut -d '.' -f 1

RUN adduser --disabled-password --gecos '' bootcamp && \
    adduser bootcamp sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chown -R bootcamp /home/bootcamp

USER bootcamp

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:/usr/local/bin/python3:/usr/local/bin/pip3:$PATH

WORKDIR /home/bootcamp

# tbcp/debian:latest
