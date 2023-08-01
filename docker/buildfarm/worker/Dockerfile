FROM grpc_buildfarm_issue-buildfarm-base

WORKDIR /root/bazel-buildfarm
CMD ["bazel", "run", "-c", "opt", \
    "//src/main/java/build/buildfarm:buildfarm-shard-worker", "--", \
    "--jvm_flag=-Dlogging.config=file:/root/bazel-buildfarm/config/logging.properties", \
    "/root/bazel-buildfarm/config/config.yml"]
EXPOSE 8981
