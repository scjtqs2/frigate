#!/bin/zsh
VERSION="0.16.0"
COMMIT_HASH=$(git log -1 --pretty=format:"%h")
echo "VERSION = \"${VERSION}-${COMMIT_HASH}\"" > frigate/version.py
IMAGE_TAG="ghcr.io/blakeblackshear/frigate:0.15.1"

docker build -t "${IMAGE_TAG}" -f docker/main/Dockerfile .
#docker push "${IMAGE_TAG}"
