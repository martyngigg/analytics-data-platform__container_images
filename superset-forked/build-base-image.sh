#!/usr/bin/env bash
# Clones our fork and builds the base image
set -euo pipefail

GIT_REPO_URL=https://github.com/martyngigg/superset/
BRANCH=allow_prefixed_paths
REV=901412e9a8346153c26949b4e8d5085856cc9bf2
IMAGE_TAG=local/superset-build:latest

# clone
work_dir=$(mktemp -d)
trap "rm -rf \"$work_dir\"" EXIT

echo "Cloning from $GIT_REPO_URL"
git clone --single-branch --branch $BRANCH $GIT_REPO_URL $work_dir
pushd $work_dir
git checkout $REV

# build image
docker build \
  --build-arg DEV_MODE=false \
  --build-arg INCLUDE_FIREFOX=true \
  --build-arg INCLUDE_CHROME=false \
  --target lean \
  --tag $IMAGE_TAG \
  .

echo "Successfully built $IMAGE_TAG"
