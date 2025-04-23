#!/bin/zsh

COMMIT_HASH=$(git log -1 --pretty=format:"%h"|tail -1)
VERSION="dg1"
IMAGE_REPO="scjtqs/frigate"
GITHUB_REF_NAME=$(git rev-parse --abbrev-ref HEAD)
docker buildx create --name multiarch-builder --use
docker buildx build --file docker/main/Dockerfile . \
    --tag ${IMAGE_REPO}:${GITHUB_REF_NAME}-${COMMIT_HASH} \
    --platform linux/amd64 \
    --push
docker buildx rm multiarch-builder