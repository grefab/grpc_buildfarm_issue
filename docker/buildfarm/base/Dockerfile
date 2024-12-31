FROM grpc_buildfarm_issue-build

# buildfarm basics
WORKDIR /root
RUN git clone https://github.com/buildfarm/buildfarm.git
WORKDIR /root/buildfarm

# config
COPY config.yml config/
COPY logging.properties config/

# buildfarm 2024-12-30
RUN git checkout tags/2.13.0
RUN bazel build -c opt --javabase=@bazel_tools//tools/jdk:remote_jdk11 //src/main/java/build/buildfarm:buildfarm-server
RUN bazel build -c opt --javabase=@bazel_tools//tools/jdk:remote_jdk11 //src/main/java/build/buildfarm:buildfarm-shard-worker
