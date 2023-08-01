FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

RUN apt update
RUN apt upgrade -y
RUN apt install -y aptitude

# Install our dev basics
RUN apt install -y \
    git \
    python3 \
    openssh-client \
    ca-certificates \
    locales \
    sudo \
    curl \
    wget \
    build-essential \
    pkg-config
RUN apt install -y clang clang-format clang-tidy clang-tools clangd lld lldb llvm
RUN apt install -y clang-14 clang-format-14 clang-tidy-14 clang-tools-14 clangd-14 lld-14 lldb-14 llvm-14
RUN apt install -y libstdc++-12-dev
RUN apt install -y openjdk-11-jdk openjdk-11-jre
ENV CC clang-14
ENV CXX clang++-14

# Bazel with bazelisk
RUN apt install -y unzip
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.17.0/bazelisk-linux-amd64
RUN chmod +x /root/bazelisk-linux-amd64
RUN mv /root/bazelisk-linux-amd64 /usr/local/bin/bazel
ENV BAZEL_CXXOPTS='-std=c++17'
RUN bazel version

# Ready to go!
WORKDIR /src

CMD ["/bin/bash"]
