#!/bin/sh
export CURRENT_UID=$(id -u):$(id -g)
export MUID=$(id -u)

# Verify that DD_PLATFORM exists, and set it if not
if [ -z ${DD_PLATFORM} ]; then export DD_PLATFORM=$PWD/../..; fi

# Verify that DD_PLATFORM/version.json file exists, and create it if not
if [ ! -f ${DD_PLATFORM}/version.json ]; then touch ${DD_PLATFORM}/version.json; fi

# Update platform configuration
git pull

# Stop UI containers and clean volumes up
docker-compose stop platform_ui nginx ouroboros
docker-compose rm -v -f platform_ui nginx

# Remove named volume
docker volume rm -f cpu_platform_ui

# Update containers
docker-compose pull --no-parallel

# Restart with updated containers
# Warning: this may kill your running jobs
docker-compose up -d
