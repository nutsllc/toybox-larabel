#!/bin/bash

: ${DB_CONNECTION:=mysql}
: ${DB_HOST:=127.0.0.1}
: ${DB_PORT:=3306}
: ${DB_DATABASE:=homestead}
: ${DB_USERNAME:=homestead}
: ${DB_PASSWORD:=secret}
: ${LARAVEL_TZ:=UTC}
: ${LARAVEL_LOCALE:=en}

[ -f ${HOME}/laravel.tar.gz ] && {
    tar xzf ${HOME}/laravel.tar.gz && {
        chown -R ${USER_NAME}:${GROPU_NAME} /usr/share/nginx/laravel
        env=/usr/share/nginx/laravel/.env
        config_app=/usr/share/nginx/laravel/config/app.php
        sed -i -e "s/^\(DB_CONNECTION=\).*$/\1${DB_CONNECTION}/" ${env}
        sed -i -e "s/^\(DB_HOST=\).*$/\1${DB_HOST}/" ${env}
        sed -i -e "s/^\(DB_PORT=\).*$/\1${DB_PORT}/" ${env}
        sed -i -e "s/^\(DB_DATABASE=\).*$/\1${DB_DATABASE}/" ${env}
        sed -i -e "s/^\(DB_USERNAME=\).*$/\1${DB_USERNAME}/" ${env}
        sed -i -e "s/^\(DB_PASSWORD=\).*$/\1${DB_PASSWORD}/" ${env}
        sed -i -e "s:^\(.*'timezone' => \)'UTC',$:\1'${LARAVEL_TZ}',:" ${config_app}
        sed -i -e "s/^\(.*'locale' => \)'en',$/\1'${LARAVEL_LOCALE}',/" ${config_app}
        php /usr/share/nginx/laravel/artisan migrate
    }
    rm ${HOME}/laravel.tar.gz
}

exec $@
