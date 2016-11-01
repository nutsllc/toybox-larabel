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
    site_confdir=/etc/apache2/sites-available
    sed -i -e "s:^\(.*DocumentRoot \)/var/www/html$:\1${DOCUMENT_ROOT}:" ${site_confdir}/000-default.conf
    sed -i -e "s:^\(.*DocumentRoot \)/var/www/html$:\1${DOCUMENT_ROOT}:" ${site_confdir}/default-ssl.conf

    cd /var/www
    tar xzf ${HOME}/laravel.tar.gz && {
        chown -R www-data:www-data /var/www/laravel
        env=/var/www/laravel/.env
        config_app=/var/www/laravel/config/app.php
        sed -i -e "s/^\(DB_CONNECTION=\).*$/\1${DB_CONNECTION}/" ${env}
        sed -i -e "s/^\(DB_HOST=\).*$/\1${DB_HOST}/" ${env}
        sed -i -e "s/^\(DB_PORT=\).*$/\1${DB_PORT}/" ${env}
        sed -i -e "s/^\(DB_DATABASE=\).*$/\1${DB_DATABASE}/" ${env}
        sed -i -e "s/^\(DB_USERNAME=\).*$/\1${DB_USERNAME}/" ${env}
        sed -i -e "s/^\(DB_PASSWORD=\).*$/\1${DB_PASSWORD}/" ${env}
        sed -i -e "s:^\(.*'timezone' => \)'UTC',$:\1'${LARAVEL_TZ}',:" ${config_app}
        sed -i -e "s/^\(.*'locale' => \)'en',$/\1'${LARAVEL_LOCALE}',/" ${config_app}
        php /var/www/laravel/artisan migrate
        rm ${HOME}/laravel.tar.gz
    }
}

exec $@
