#!/bin/bash

source /home/ubu/secret.sh

docker run \
    --rm \
    --entrypoint "" \
    --network='shvirtd-example-python-main_backend' \
    -v /opt/backup:/backup \
    schnitzler/mysqldump \
    sh -c "apk add mariadb-connector-c-dev && mysqldump --opt -h db -u ${MYSQL_USER} -p\"${MYSQL_PASSWORD}\" \"--no-tablespaces\" \"--result-file=/backup/dump-$(date +"%Y-%m-%d_%T").sql\" ${MYSQL_DB}"
