#!/bin/bash

self=$(cd $(dirname $0);pwd)
src=${self}/../seed
dist=${self}/..

dirs=(
    "${dist}/5.1/php5.6-apache"
    "${dist}/5.1/php7.0-apache"
    "${dist}/5.2/php5.6-apache"
    "${dist}/5.2/php7.0-apache"
    "${dist}/5.3/php5.6-apache"
    "${dist}/5.3/php7.0-apache"
)

dirs_data=(
    "${dist}/5.1/data-container"
    "${dist}/5.2/data-container"
    "${dist}/5.3/data-container"
)

for d in ${dirs[@]}; do
    [ -d ${d} ] && rm -r ${d}
    lara_ver=$(echo ${d} | awk -F "/" '{print $(NF - 1)}').*
    php_ver=$(echo ${d} | awk -F "/" '{print $NF}'| sed -e "s/php//" -e "s/-apache//" )
    printf "Generate: Dockerfile for Laravel ${lara_ver} with PHP ${php_ver} ..."
    mkdir -p ${d}
    cp ${src}/Dockerfile-seed ${d}/Dockerfile
    cp ${src}/docker-entrypoint.sh-seed ${d}/docker-entrypoint.sh
    chmod 755 ${d}/docker-entrypoint.sh
    sed -i -e "s/{{LARAVEL_VERSION}}/${lara_ver}/" ${d}/Dockerfile
    sed -i -e "s/{{PHP_VERSION}}/${php_ver}/" ${d}/Dockerfile
    echo "done."
done

for d in ${dirs_data[@]}; do
    [ -d ${d} ] && rm -r ${d}
    lara_ver=$(echo ${d} | awk -F "/" '{print $(NF - 1)}').*
    printf "Generate: Dockerfile for Laravel ${lara_ver} data container ..."
    mkdir -p ${d}
    cp ${src}/data-container/Dockerfile-seed ${d}/Dockerfile
    cp ${src}/data-container/docker-entrypoint.sh-seed ${d}/docker-entrypoint.sh
    chmod 755 ${d}/docker-entrypoint.sh
    sed -i -e "s/{{LARAVEL_VERSION}}/${lara_ver}/" ${d}/Dockerfile
    echo "done."
done

echo "complete!"

exit 0
