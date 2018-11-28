#!/bin/bash

. `dirname $0`/env.sh

mysql_image_name='olog-mysql-db'

# Verifies if a container with the same name is already running.
CONTAINERS=$(docker ps -a | grep ${DOCKER_RUN_NAME})

if [ ! -z ${CONTAINERS:+x} ]; then

    echo "A container with the name ${DOCKER_RUN_NAME} is already running..."

    # Stops running container and deletes it.
    echo "Executing 'docker stop ${DOCKER_RUN_NAME}' ..."
    docker stop ${DOCKER_RUN_NAME} &> /dev/null

    echo "Executing 'docker rm ${DOCKER_RUN_NAME}' ..."
    docker rm ${DOCKER_RUN_NAME} &> /dev/null
fi

docker run -d --name=${DOCKER_RUN_NAME} \
    -p ${OLOG_ADMIN_PORT}:${OLOG_ADMIN_PORT} -p ${OLOG_SSL_PORT}:${OLOG_SSL_PORT} \
    --link=${mysql_image_name} \
    ${DOCKER_MANTAINER_NAME}/${DOCKER_NAME}:${DOCKER_TAG} \
    asadmin --user=admin --passwordfile=/tmp/glassfishpwd start-domain -v

docker logs -f ${DOCKER_RUN_NAME}
