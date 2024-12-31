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

# Add the LLVM repository
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-18 main" > /etc/apt/sources.list.d/llvm-toolchain-jammy-18.list
RUN apt update
# Instal clang and toolchain stuff
RUN apt install -y clang-18 clang-format-18 clang-tidy-18 clangd-18 lld-18 lldb-18 llvm-18
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-18 100
RUN update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-18 100
RUN update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-18 100
RUN update-alternatives --install /usr/bin/lld lld /usr/bin/lld-18 100
RUN update-alternatives --install /usr/bin/lldb lldb /usr/bin/lldb-18 100

RUN apt install -y libstdc++-12-dev
RUN apt install -y openjdk-11-jdk openjdk-11-jre
ENV CC=clang-18
ENV CXX=clang++-18

# Bazel with bazelisk
RUN apt install -y unzip
RUN wget https://github.com/bazelbuild/bazelisk/releases/download/v1.25.0/bazelisk-linux-amd64
RUN chmod +x /root/bazelisk-linux-amd64
RUN mv /root/bazelisk-linux-amd64 /usr/local/bin/bazel
ENV BAZEL_CXXOPTS='-std=c++20'
ENV USE_BAZEL_FALLBACK_VERSION=warn:7.4.1
RUN bazel version

# Ready to go!
WORKDIR /src

CMD ["/bin/bash"]
