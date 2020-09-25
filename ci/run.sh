#!/bin/bash

set -e
set -x
set -o pipefail

export MODE=$1
export DD_PLATFORM=$PWD
export DD_PORT=50000-50100
export CURRENT_UID=$(id -u):$(id -g)
export MUID=$(id -u)

PROJECT=jenkins-test-${RANDOM}

cd code/$MODE/

cleanup() {
    ret=$?
    docker-compose -p $PROJECT ps
    docker-compose -p $PROJECT down --remove-orphans
    exit=$ret
}
trap cleanup EXIT

docker-compose -p $PROJECT up -d

PORT=$(docker port "${PROJECT}_platform_ui_1" 80/tcp | awk -F: '{print $2}')

timeout 60 sh -c "until nc -z localhost $PORT; do sleep 1; done"

sleep 5

curl -s --head --request GET localhost:$PORT | head -1 | grep 'HTTP/1.1 200'
curl -s --head --request GET http://localhost:$PORT/api/deepdetect/info | head -1 | grep 'HTTP/1.1 200'
curl -s --head --request GET http://localhost:$PORT/filebrowser/sw.js | head -1 | grep 'HTTP/1.1 200'
curl -s --head --request GET http://localhost:$PORT/docker-logs/ | head -1 | grep 'HTTP/1.1 200'
