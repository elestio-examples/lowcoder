#!/usr/bin/env bash
cp ./deploy/docker/Dockerfile Dockerfile
docker buildx build . --output type=docker,name=elestio4test/lowcoder:latest | docker load