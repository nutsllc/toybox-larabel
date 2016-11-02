FROM alpine:3.4

ENV LARAVEL_VERSION=5.2.*.*

# ---------------------------------------------------------
# Base
# ---------------------------------------------------------
RUN apk add --update --no-cache \
        bash \
        sudo \
        curl \
        git \
        zip \
    && apk del --purge
#
# ---------------------------------------------------------
# User
# ---------------------------------------------------------
ENV GROUP_NAME=laravel \
    USER_NAME=laravel \
    USER_PASSWORD=password

RUN set -x \
    && addgroup ${GROUP_NAME} \
    && adduser -D -G ${GROUP_NAME} ${USER_NAME} \
    && echo ${USER_NAME}:${USER_PASSWORD} | chpasswd \
    && echo "Defaults visiblepw" >> /etc/sudoers.d/${USER_NAME} \
    && echo "%${GROUP_NAME} ALL=(ALL) ALL" >> /etc/sudoers.d/${USER_NAME} \
    && echo "%${GROUP_NAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER_NAME}

# ---------------------------------------------------------
# PHP
# ---------------------------------------------------------
ENV PHP_VERSION=5
#ENV PHP_VERSION=7
RUN apk add --update --no-cache \
        php${PHP_VERSION} \
        php${PHP_VERSION}-openssl \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-phar \
        php${PHP_VERSION}-dom \
        php${PHP_VERSION}-pdo \
        php${PHP_VERSION}-pdo_sqlite \
        php${PHP_VERSION}-pdo_mysql \
        php${PHP_VERSION}-pdo_pgsql \
    && apk del --purge

# ---------------------------------------------------------
# composer
# ---------------------------------------------------------
USER ${USER_NAME}
ENV PATH=${PATH}:${HOME}/.composer/vendor/bin
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=${HOME} --filename=composer \
    && sudo mv ${HOME}/composer /usr/bin

# ---------------------------------------------------------
# Laravel
# ---------------------------------------------------------
RUN sudo mkdir /usr/share/nginx \
    && sudo chown ${USER_NAME}:${GROUP_NAME} /usr/share/nginx

RUN cd ${HOME} && composer create-project --prefer-dist "laravel/laravel=${LARAVEL_VERSION}" /usr/share/nginx/laravel \
    && tar czf ${HOME}/laravel.tar.gz /usr/share/nginx/laravel \
    && rm -r /usr/share/nginx/laravel

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
