FROM debian:latest

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt update && apt upgrade -y

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ | tee -a /etc/timezone
RUN apt install -y tzdata

RUN apt install -y \
    sudo build-essential gcc shc make cmake \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    zip wget curl nano git util-linux file \
    shellcheck

RUN apt autoremove -y

RUN adduser --disabled-password --gecos '' bootcamp && \
    adduser bootcamp sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    chown -R bootcamp /home/bootcamp

USER bootcamp

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:/usr/local/bin/python3:/usr/local/bin/pip3:$PATH

WORKDIR /home/bootcamp

# tbcp/debian:latest
