#!/bin/sh

set -e

if [ -z "${INPUT_USERNAME}" ]; then
  echo "Missing username"
  exit 1
fi

if [ -z "${INPUT_PASSWORD}" ]; then
  echo "Missing password"
  exit 1
fi

echo ${INPUT_PASSWORD} | docker login -u ${INPUT_USERNAME} --password-stdin ${INPUT_REGISTRY}

sh -c "${INPUT_ARGS}"

docker logout