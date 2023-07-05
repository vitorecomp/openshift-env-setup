#!/bin/bash

#get the script path
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_PATH/script-lib/shell-utilities.sh
parse_commands $SCRIPT_PATH "$@"

# validate commands
validate_installation_commands

# validate login
validate_login

# load the env file
source $SCRIPT_PATH/application.conf

# start the installation

# if dedicated machines
if [ "$DEPLOYMENT_TYPE" == "dedicated" ]; then
    # install the dedicated machines
    source $SCRIPT_PATH/dedicated-machines/dedicated-machines.sh
    create_dedicated_machines
fi

# if kafka
if [ "$KAFKA_DEPLOYMENT" == "true" ]; then
    # install kafka
    source $SCRIPT_PATH/kafka/kafka.sh
    create_kafka
fi

# if postgres
if [ "$POSTGRES_DEPLOYMENT" == "true" ]; then
    # install postgres
    source $SCRIPT_PATH/postgres/postgres.sh
    create_postgres
fi

#if redis
if [ "$REDIS_DEPLOYMENT" == "true" ]; then
    # install redis
    source $SCRIPT_PATH/redis/redis.sh
    create_redis
fi

#if data foundation s3
if [ "$DATA_FOUNDATION_S3_DEPLOYMENT" == "true" ]; then
    # install data foundation s3
    source $SCRIPT_PATH/data-foundation-s3/data-foundation-s3.sh
    create_data_foundation_s3
fi


#if data-science services
if [ "$DATA_SCIENCE_DEPLOYMENT" == "true" ]; then
    # install data-science services
    source $SCRIPT_PATH/data-science/data-science.sh
    create_data_science
fi

#if k6 load test
if [ "$K6_LOAD_TEST_DEPLOYMENT" == "true" ]; then
    # install k6 load test
    source $SCRIPT_PATH/k6-load-test/k6-load-test.sh
    create_k6_load_test
fi


