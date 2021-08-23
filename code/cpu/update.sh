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
        --platform-ui-only )  shift
                               PLATFORM_UI_ONLY=1
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

# Update platform configuration
git pull

# Stop UI containers and clean volumes up
docker-compose pull --no-parallel platform_ui

if [ -z ${PLATFORM_UI_ONLY} ]; then
  # restart all platform containers
  docker-compose -p $COMPOSE_PROJECT_NAME up -d --remove-orphans
else
  # only restart platform_ui
  docker-compose -p $COMPOSE_PROJECT_NAME up -d --no-deps platform_ui
fi

# Remove legacy named volume
docker_platform_name="${COMPOSE_PROJECT_NAME}_platform_ui"
if [[ $(docker volume ls --filter "name=$docker_platform_name" --format '{{.Name}}') == $docker_platform_name* ]];
then
    docker volume rm -f $docker_platform_name ;
fi
