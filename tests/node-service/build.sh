#!/usr/bin/env bash
cp ./deploy/docker/Dockerfile Dockerfile
docker buildx build --target lowcoder-ce-node-service . --output type=docker,name=elestio4test/lowcoder-node-service:latest | docker load