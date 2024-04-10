#!/usr/bin/env bash
cp ./deploy/docker/Dockerfile Dockerfile
docker buildx build --target lowcoder-ce-frontend . --output type=docker,name=elestio4test/lowcoder-frontend:latest | docker load