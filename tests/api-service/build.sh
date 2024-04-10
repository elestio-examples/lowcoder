#!/usr/bin/env bash
cp ./deploy/docker/Dockerfile Dockerfile
docker buildx build --target lowcoder-ce-api-service . --output type=docker,name=elestio4test/lowcoder-api-service:latest | docker load