#! /bin/bash
cd "$(dirname "$0")" # go to directory of this script

# first, build a docker image that is our build environment.
docker build -t grpc_buildfarm_issue-build ./docker
# docker-compose will build services that depend on this
docker build -t grpc_buildfarm_issue-buildfarm-base ./docker/buildfarm/base
# prepare buildfarm actors
docker build -t grpc_buildfarm_issue-buildfarm-worker ./docker/buildfarm/worker
docker build -t grpc_buildfarm_issue-buildfarm-master ./docker/buildfarm/server

echo "Preparations done. As next step we will build gRPC, that might take a while"
echo "press any key to continue..."
read -r

# build our code inside the container. THIS SHOULD WORK.
# it will take a while because it builds grpc completely from scratch.
docker run --rm -v "$(pwd):/src" grpc_buildfarm_issue-build bazel build //...
echo "Building done. You should see something like:"
echo "INFO: 3465 processes: 1232 internal, 2233 processwrapper-sandbox."
echo "INFO: Build completed successfully, 3465 total actions"
echo "press any key to continue..."
read -r

# clean workspace, just to be sure
docker run --rm -v "$(pwd):/src" grpc_buildfarm_issue-build bazel clean


# start buildfarm infrastructure as docker-compose
echo "Starting buildfarm as docker-compose in the background. Please give it a moment to spin up"
docker-compose up -d

# build our code inside the container, but use buildfarm this time. THIS SHOULD FAIL.
echo "Now we will use buildfarm for the same process. This will fail."
MY_LOCAL_IP=10.0.0.136
echo "PLEASE ADAPT SCRIPT TO USE THE LOCAL IP OF YOUR MACHINE, CURRENTLY SET TO $MY_LOCAL_IP"
echo "press any key to continue..."
read -r
docker run --rm -v "$(pwd):/src" grpc_buildfarm_issue-build bazel build --remote_executor=grpc://$MY_LOCAL_IP:8980 //...
echo "Finished build using buildfarm. This should have failed"
echo "press any key to continue..."
read -r

# stop and clean up buildfarm
echo "Stopping buildfarm"
docker-compose down

# clean workspace and quit
docker run --rm -v "$(pwd):/src" grpc_buildfarm_issue-build bazel clean
echo "Finished example"
