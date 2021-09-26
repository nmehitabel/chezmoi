#!/bin/bash

set -eufo pipefail

cd ../..
for distribution in "$@"; do
    dockerfile="assets/docker/${distribution}.Dockerfile"
    if [ ! -f "${dockerfile}" ]; then
        echo "${dockerfile} not found"
        exit 1
    fi
    image="$(docker build . -f "assets/docker/${distribution}.Dockerfile" -q)"
    docker run --rm --volume "${PWD}:/chezmoi" "${image}"
done
