#!/bin/bash

script="update.sh"
#Declare the number of mandatory args
margs=0

# Common functions - BEGIN
function example {
    echo -e "example with *another_${PWD##*/}* project name: ./$script -p another_${PWD##*/}\n"
}

function usage {
    echo -e "usage: ./$script [OPTIONS]\n"
}

function help {
  usage
    echo -e "OPTIONS:"
    echo -e ""
    echo -e "  -p, --project-name PROJECT_NAME Project name used for this docker-compose installation."
    echo -e "                                  Default: ${PWD##*/}"
    echo -e ""
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

COMPOSE_PROJECT_NAME=${PWD##*/}

# Args while-loop
while [ "$1" != "" ];
do
    case $1 in
        -p  | --project-name )  shift
                               COMPOSE_PROJECT_NAME=$1
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
margs_check $COMPOSE_PROJECT_NAME

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
docker_platform_name=${COMPOSE_PROJECT_NAME}_platform_ui
if [[ $(docker volume ls --filter "name=$docker_platform_name" --format '{{.Name}}') == $docker_platform_name* ]];
then
    docker volume rm -f $docker_platform_name ;
else
    echo -e ""
    echo -e "WARNING: ${docker_platform_name} docker volume is not available."
    echo -e ""
    echo -e "Please verify the project name *${COMPOSE_PROJECT_NAME}* parameter and the existing volumes."
    echo -e ""
    echo -e "Command to check existing volumes: docker volume ls --format '{{.Name}}'"
    echo -e ""
fi

# Update containers
docker-compose pull --no-parallel nginx platform_ui

# Restart with updated containers
docker-compose up -d nginx platform_ui
