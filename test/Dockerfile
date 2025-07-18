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
    coreutils \
    locales && \
    rm -rf /var/lib/apt/lists/*

# Generate the locale
RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Create non-root user
RUN useradd -m -s /bin/bash tester && \
    echo "tester ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER tester
WORKDIR /home/tester

# Copy your repo
COPY . /home/tester/dotfiles

ENTRYPOINT ["/bin/bash"]
