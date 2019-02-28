#!/bin/sh
export CURRENT_UID=$(id -u):$(id -g)
export MUID=$(id -u)

# Update platform configuration
git pull

# Stop UI containers and clean volumes up
docker-compose stop platform_ui nginx
docker-compose rm -v -f platform_ui nginx

# Remove named volume
docker volume rm -f cpu_platform_ui

# Update containers
docker-compose pull

# Restart with updated containers
# Warning: this may kill your running jobs
docker-compose up -d
