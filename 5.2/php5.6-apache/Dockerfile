FROM nutsllc/toybox-php:5.6-apache

ENV LARAVEL_VERSION=5.2.* \
    DOCUMENT_ROOT=/var/www/laravel/public

RUN cd ${HOME} \
    && composer create-project --prefer-dist "laravel/laravel=${LARAVEL_VERSION}" ${HOME}/laravel \
    && tar czf laravel.tar.gz laravel/ \
    && rm -r laravel/

COPY docker-entrypoint.sh /entrypoint-laravel.sh

ENTRYPOINT ["/entrypoint-php.sh"]
CMD ["/entrypoint-laravel.sh","apache2-foreground"]
