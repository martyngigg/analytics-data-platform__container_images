#!/usr/bin/env bash
#
set -euo pipefail

function fail_if_empty_environ_var() {
  local var_name="$1"
  local var_value="${!var_name:-}"
  if [ -z "${var_value}" ]; then
    echo "Expected variable '$1' to be defined but it is empty."
    exit 1
  fi
}

# Check credentials available as environment variables
fail_if_empty_environ_var CR_USERNAME
fail_if_empty_environ_var CR_PAT

# Cli
fully_qualified_image_name="$1"
if [ -z "$fully_qualified_image_name" ]; then
  echo "Usage: ${0} fully_qualified_image_name"
  exit 1
fi

# Image name parts
registry=$(echo $fully_qualified_image_name | cut -d / -f 1)
namespace=$(echo $fully_qualified_image_name | cut -d / -f 2)
image_tag=$(echo $fully_qualified_image_name | cut -d / -f 3)

if [[ -z "$registry" ]] || [[ -z "$namespace" ]]; then
  echo "Expected fully-qualified image name, e.g. 'ghcr.io/repo/image_tag'"
  exit 1
fi

echo "Logging into $registry as $CR_USERNAME"
echo $CR_PAT | docker login $registry -u $CR_USERNAME --password-stdin

echo "Pushing $fully_qualified_image_name"
docker push $fully_qualified_image_name
