FROM debian:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=bootcamp

RUN apt update && apt upgrade -y

RUN apt install -y sudo

RUN adduser --disabled-password --gecos '' $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

USER bootcamp

RUN sudo apt install -y ca-certificates gnupg git curl build-essential

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:$PATH

WORKDIR /home/bootcamp
