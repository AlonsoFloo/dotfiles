FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash \
    zsh \
    git \
    curl \
    sudo \
    coreutils \
    jq \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash testuser && echo "testuser:testuser" | chpasswd && adduser testuser sudo
RUN echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

COPY --chown=testuser:testuser . /tmp/dotfiles-src

CMD ["/bin/bash", "/tmp/dotfiles-src/tests/test_runner.sh"]
