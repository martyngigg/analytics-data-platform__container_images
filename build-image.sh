#!/usr/bin/env bash
# Build an image for the Dockerfile in the given directory
# The tag is defined in a file called 'tag' next to the Dockerfile.
set -euo pipefail

# Defaults
PLATFORM="linux/amd64"
REGISTRY="ghcr.io"
NAMESPACE="martyngigg"

# Functions
function docker_build() {
  local dockerfile_path=$1
  local tag=$2
  docker build  --platform $PLATFORM --tag "$tag" "$dockerfile_path"
}

# Cli Args
if [ $# -ne 1 ]; then
  echo "Usage: ${0} dockerfile_path"
  exit 1
fi

# Build
dockerfile_path=$1
tag=$(cat "$dockerfile_path/tag")
fully_qualified_image_name="${REGISTRY}/${NAMESPACE}/${tag}"
docker_build "$dockerfile_path" $fully_qualified_image_name

echo "Successfully built $fully_qualified_image_name"
