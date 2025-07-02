# test/Dockerfile.test
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    sudo \
    bash \
    ca-certificates \
    software-properties-common \
    build-essential \
    gnupg2 \
    unzip \
    coreutils && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -s /bin/bash tester && \
    echo "tester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER tester
WORKDIR /home/tester

# Copy your repo
COPY . /home/tester/dotfiles

ENTRYPOINT ["/bin/bash"]
