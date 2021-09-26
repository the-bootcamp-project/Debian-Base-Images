FROM debian:latest

ENV LANGUAGE en_US.utf8
ENV LC_ALL en_US.utf8
ENV LC_CTYPE en_US.utf8
ENV LC_COLLATE en_US.utf8
ENV LC_MESSAGES en_US.utf8
ENV LANG en_US.utf8

RUN apt update && apt upgrade -y
RUN apt install -y locales

RUN echo "Etc/UTC" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

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
