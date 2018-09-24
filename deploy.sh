#!/usr/bin/env bash

# include parse_yaml function

source ./includes/parse_yaml.sh

if [ -z ${1+x} ]; then
    echo "Missing first (project name) argument"
    exit 1
fi

if [ -z ${2+x} ]; then
    echo "Missing second (environment) argument"
    exit 1
fi

MAPPING="./config/mapping.yml"
DEPLOY_KEYS=("ssh_config" "compose_file" "docker_env")
PROJECT="$1"
ENV="$2"
RESTART_DOCKER="$3"

if [ -f $MAPPING ]; then
    create_variables $MAPPING
fi

validate_config "$PROJECT" "$ENV" ${DEPLOY_KEYS[@]}

valid="$?"
if [ $valid != 0 ]; then
    echo "Invalid mapping"
    exit 1
fi

BASE="sites_${PROJECT}_${ENV}"
SSH_CONFIG="${BASE}_ssh_config"
COMPOSE_FILE="${BASE}_compose_file"
DOCKER_ENV="${BASE}_docker_env"

COMMAND="docker deploy -c ${!COMPOSE_FILE} ${!DOCKER_ENV} --with-registry-auth"

read -p "You are about to execute command: ${COMMAND}. Do you want to continue (y/N) " INPUT

if [ "$INPUT" != "y" -a "$INPUT" != "Y" ];
    then
        echo "Exiting"
        exit 1
    else
        eval $COMMAND
fi

