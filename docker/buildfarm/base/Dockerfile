FROM grpc_buildfarm_issue-build

# buildfarm basics
WORKDIR /root
RUN git clone https://github.com/bazelbuild/bazel-buildfarm.git
WORKDIR /root/bazel-buildfarm

# config
COPY config.yml config/
COPY logging.properties config/

# buildfarm 2023-07-26
RUN git checkout abcd8fc89c9e23e6b39139c15cb504383d346a65
RUN bazel build -c opt --javabase=@bazel_tools//tools/jdk:remote_jdk11 //src/main/java/build/buildfarm:buildfarm-server
RUN bazel build -c opt --javabase=@bazel_tools//tools/jdk:remote_jdk11 //src/main/java/build/buildfarm:buildfarm-shard-worker
