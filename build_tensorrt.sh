#!/bin/zsh
VERSION="0.16.0"
COMMIT_HASH=$(git log -1 --pretty=format:"%h")
echo "VERSION = \"${VERSION}-${COMMIT_HASH}\"" > frigate/version.py
IMAGE_TAG="ghcr.io/blakeblackshear/frigate:0.15.1-tensorrt"

export COMPUTE_LEVEL="50 60 70 80 90" && docker build -t tensorrt-base -f docker/tensorrt/Dockerfile.base .
docker build -t "${IMAGE_TAG}" -f docker/tensorrt/Dockerfile.amd64 .
#docker push "${IMAGE_TAG}"
