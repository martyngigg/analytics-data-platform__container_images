#!/usr/bin/env bash
# Build an image for the Dockerfile in the given directory
# The tag is defined in a file called 'tag' next to the Dockerfile.
set -euo pipefail

# Defaults
PLATFORM="linux/amd64"
REGISTRY="ghcr.io"
NAMESPACE="martyngigg"
BUILD_BASE_IMAGE_FILE="build-base-image.sh"

# Functions
function fail_with_msg() {
  echo $*
  exit 1
}

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
dockerfile_path=$1

# Valid tag?
tag_file="$dockerfile_path/tag"
test -f "$tag_file" || fail_with_msg "Missing required file '$dockerfile_path/tag'."
tag=$(cat "$tag_file")
test -n "$tag" || fail_with_msg "'$dockerfile_path/tag' file is empty"

# Do we need to build a base image?
test -f "$dockerfile_path/$BUILD_BASE_IMAGE_FILE" && "$dockerfile_path/$BUILD_BASE_IMAGE_FILE"

# Build
fully_qualified_image_name="${REGISTRY}/${NAMESPACE}/${tag}"
docker_build "$dockerfile_path" $fully_qualified_image_name

echo "Successfully built $fully_qualified_image_name"
