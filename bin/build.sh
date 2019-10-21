#!/bin/bash

self=$(cd $(dirname $0);pwd)
base=${self}/..

function _build() {
    vers=($@)
    [ -z "${vers}" ] && {
#        vers=(5.1 5.2 5.3 5.4)
        vers=(5.2)
    }

    for v in ${vers[@]}; do
        lara_ver=${v}
#        php_ver=(5.6 7.0)
        php_ver=(7.0)
        for pv in ${php_ver[@]}; do
            d=${base}/${lara_ver}/php${pv}-apache
            echo ">>> Build: Container for Laravel ${lara_ver} with PHP ${pv}"
            echo ">>> docker build -t laravel:${lara_ver}-php${pv}-apache ..."
            [ -f ${d}/Dockerfile ] && [ -f ${d}/docker-entrypoint.sh ] && {
                docker build -t nutsllc/toybox-laravel:${lara_ver}-php${pv}-apache ${d}
                echo "done."
            }
        done
    done
    echo "complete!"
}

[[ ! $(type docker) ]] && {
    echo "you need to install docker."
    exit 2
}

_build $@

exit 0
