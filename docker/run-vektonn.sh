#!/bin/bash
set -e

if [ $# -lt 2 ]; then
    echo "ERROR: Invalid number of arguments";
    echo "Usage: run-vektonn.sh index_name index_version [index_shard_id]";
    exit 1;
fi

export VEKTONN_INDEX_NAME=$1
export VEKTONN_INDEX_VERSION=$2
export VEKTONN_INDEX_SHARD_ID=${3:-SingleShard}

THIS_SCRIPT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
DOCKER_COMPOSE_FILE=$THIS_SCRIPT_DIR/docker-compose.yaml

docker-compose --file "$DOCKER_COMPOSE_FILE" down
docker-compose --file "$DOCKER_COMPOSE_FILE" up --detach
