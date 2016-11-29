#!/bin/bash
set -e

LARAVEL_ROOT=/var/www/laravel
${DOCUMENT_ROOT}=${LARAVEL_ROOT}/public
: ${LARAVEL_TZ:=UTC}
: ${LARAVEL_LOCALE:=en}

# Apache settings
site_confdir=/etc/apache2/sites-available
sed -i -e "s:^\(.*DocumentRoot \)/var/www/html$:\1${DOCUMENT_ROOT}:" ${site_confdir}/000-default.conf
sed -i -e "s:^\(.*DocumentRoot \)/var/www/html$:\1${DOCUMENT_ROOT}:" ${site_confdir}/default-ssl.conf

[ -f ${HOME}/laravel.tar.gz ] && {
    cd ${LARAVEL_ROOT}/../
    tar xzf ${HOME}/laravel.tar.gz 
    rm ${HOME}/laravel.tar.gz
}

config_app=${LARAVEL_ROOT}/config/app.php
sed -i -e "s:^\(.*'timezone' => \)'UTC',$:\1'${LARAVEL_TZ}',:" ${config_app}
sed -i -e "s/^\(.*'locale' => \)'en',$/\1'${LARAVEL_LOCALE}',/" ${config_app}

env=${LARAVEL_ROOT}/.env
[ -f ${env} ] && {

    # DB settings
    [ -n ${DB_CONNECTION} ] && sed -i -e "s/^\(DB_CONNECTION=\)mysql$/\1${DB_CONNECTION}/" ${env} && {
        if [ "${DB_CONNECTION}" = "sqlite" ]; then
            sed -i -e "s/^\(DB_HOST=.*\)/#\1/" ${env}
            sed -i -e "s/^\(DB_PORT=.*\)/#\1/" ${env}
            sed -i -e "s/^\(DB_USERNAME=.*\)/#\1/" ${env}
            sed -i -e "s/^\(DB_PASSWORD=.*\)/#\1/" ${env}
            if [ -z "${DB_DATABASE}" ]; then
                sed -i -e "s/^\(DB_DATABASE=.*\)/#\1/" ${env}
            elif [ ! -f ${LARAVEL_BASE}/database/${DB_DATABASE} ]; then
                touch ${LARAVEL_ROOT}/database/${DB_DATABASE}
            fi
        else
            [ -n "${DB_HOST}" ] && sed -i -e "s/^\(DB_HOST=\).*$/\1${DB_HOST}/" ${env}
            [ -n "${DB_PORT}" ] && sed -i -e "s/^\(DB_PORT=\).*$/\1${DB_PORT}/" ${env}
            [ -n "${DB_DATABASE}" ] && sed -i -e "s/^\(DB_DATABASE=\).*$/\1${DB_DATABASE}/" ${env}
            [ -n "${DB_USER_NAME}" ] && sed -i -e "s/^\(DB_USERNAME=\).*$/\1${DB_USERNAME}/" ${env}
            [ -n "${DB_PASSWORD}" ] && sed -i -e "s/^\(DB_PASSWORD=\).*$/\1${DB_PASSWORD}/" ${env}
        fi
    }

    # Mail settings
    [ -n "${MAIL_DRIVER}" ] && sed -i -e "s/^\(MAIL_DRIVER=\).*$/\1${MAIL_DRIVER}/" ${env}
    [ -n "${MAIL_HOST}" ] && sed -i -e "s/^\(MAIL_HOST=\).*$/\1${MAIL_DRIVER}/" ${env}
    [ -n "${MAIL_PORT}" ] && sed -i -e "s/^\(MAIL_PORT=\).*$/\1${MAIL_DRIVER}/" ${env}
    [ -n "${MAIL_USERNAME}" ] && sed -i -e "s/^\(MAIL_USERNAME=\).*$/\1${MAIL_DRIVER}/" ${env}
    [ -n "${MAIL_PASSWORD}" ] && sed -i -e "s/^\(MAIL_PASSWORD=\).*$/\1${MAIL_DRIVER}/" ${env}
    [ -n "${MAIL_ENCRYPTION}" ] && sed -i -e "s/^\(MAIL_ENCRYPTION=\).*$/\1${MAIL_DRIVER}/" ${env}
}

chown -R www-data:www-data ${LARAVEL_ROOT}
#php ${DOCUMENT_ROOT}/../artisan migrate

exec $@
