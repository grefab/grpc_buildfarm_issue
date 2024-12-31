FROM grpc_buildfarm_issue-buildfarm-base

WORKDIR /root/buildfarm
CMD ["bazel", "run", "-c", "opt", \
    "//src/main/java/build/buildfarm:buildfarm-shard-worker", "--", \
    "--jvm_flag=-Dlogging.config=file:/root/buildfarm/config/logging.properties", \
    "/root/buildfarm/config/config.yml"]
EXPOSE 8981
