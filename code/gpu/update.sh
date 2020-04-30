#!/bin/bash

script="update.sh"
#Declare the number of mandatory args
margs=1

# Common functions - BEGIN
function example {
    echo -e "example: $script -p PROJECT_NAME"
}

function usage {
    echo -e "usage: $script MANDATORY [OPTION]\n"
}

function help {
  usage
    echo -e "MANDATORY:"
    echo -e "  -p, --project-name PROJECT_NAME Project name used for this docker-compose installation"
    echo -e "OPTION:"
    echo -e "  -h, --help                      Prints this help\n"
  example
}

# Ensures that the number of passed args are at least equals
# to the declared number of mandatory args.
# It also handles the special case of the -h or --help arg.
function margs_precheck {
    if [ $2 ] && [ $1 -lt $margs ]; then
        if [ $2 == "--help" ] || [ $2 == "-h" ]; then
            help
            exit
        else
            usage
            example
            exit 1 # error
        fi
    fi
}

# Ensures that all the mandatory args are not empty
function margs_check {
    if [ $# -lt $margs ]; then
        usage
        example
        exit 1 # error
    fi
}
# Common functions - END

# Main
margs_precheck $# $1

project_name=

# Args while-loop
while [ "$1" != "" ];
do
    case $1 in
        -p  | --project-name )  shift
                               project_name=$1
                               ;;
        -h   | --help )        help
                               exit
                               ;;
        *)
            echo "$script: illegal option $1"
            usage
            example
            exit 1 # error
            ;;
    esac
    shift
done

# Pass here your mandatory args for check
margs_check $project_name

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
docker_platform_name=${project_name}_platform_ui
if [[  $(docker ps --filter "name=^/$docker_platform_name$" --format '{{.Names}}') == $docker_platform_name ]];
then
    docker volume rm -f ${project_name}_platform_ui ;
else
    echo -e "WARNING: ${project_name}_platform_ui docker container is not running."
    echo -e "Please verify the project name ${project_name} parameter and the current running containers."
    echo -e "Command to check running docker container:"
    echo -e "docker ps --format '{{.Names}}'\n"
fi

# Update containers
docker-compose pull --no-parallel nginx platform_ui

# Restart with updated containers
docker-compose up -d -p $project_name nginx platform_ui
