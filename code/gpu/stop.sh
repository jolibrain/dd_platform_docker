#!/bin/sh
export CURRENT_UID=$(id -u):$(id -g)
export MUID=$(id -u)

# Verify that DD_PLATFORM exists, and set it if not
if [ -z ${DD_PLATFORM} ]; then export DD_PLATFORM=$PWD/../..; fi

docker-compose stop
