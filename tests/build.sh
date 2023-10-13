#!/usr/bin/env bash
cp ./deploy/docker/Dockerfile ./
sed -i "s~npm install -g yarn~npm install -g yarn --network-timeout 300000~g" Dockerfile
docker buildx build . --output type=docker,name=elestio4test/lowcoder:latest | docker load