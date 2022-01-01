FROM debian:latest

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=bootcamp

RUN apt update && apt upgrade -y

RUN apt install -y ca-certificates gnupg sudo git curl

RUN adduser --disabled-password --gecos '' $USER && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    chmod 0440 /etc/sudoers.d/$USER

USER bootcamp

ENV HOME /home/bootcamp
ENV PATH /home/bootcamp/.local/bin:$PATH

WORKDIR /home/bootcamp
