#!/bin/zsh
VERSION="0.16.0"
COMMIT_HASH=$(git log -1 --pretty=format:"%h")
echo "VERSION = \"${VERSION}-${COMMIT_HASH}\"" > frigate/version.py
IMAGE_TAG="ghcr.io/blakeblackshear/frigate:0.15.1-tensorrt"

#docker build -t base -f docker/main/Dockerfile .
#docker build -t tensorrt-base \
#--build-arg  COMPUTE_LEVEL="50 60 70 80 90" \
# -f docker/tensorrt/Dockerfile.base .
#docker build -t "${IMAGE_TAG}" -f docker/tensorrt/Dockerfile.amd64 .
#docker push "${IMAGE_TAG}"
# 启用 Buildx
docker buildx create --use --name frigate-builder
docker buildx inspect --bootstrap

# 构建 TensorRT 镜像（AMD64）
docker buildx bake \
  -f docker/tensorrt/trt.hcl \
  --set target.tensorrt.tags=${IMAGE_TAG} \
  --set target.tensorrt.args.COMPUTE_LEVEL="50 60 70 80 90" \
  --load \
  tensorrt
