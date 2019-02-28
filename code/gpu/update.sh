#!/bin/sh
export CURRENT_UID=$(id -u):$(id -g)
export MUID=$(id -u)

# Stop UI containers and clean volumes up
docker-compose stop platform_ui nginx
docker-compose rm -v gpu_platform_ui nginx

# Update containers
docker-compose pull

# Restart with updated containers
# Warning: this may kill your running jobs
docker-compose up -d
