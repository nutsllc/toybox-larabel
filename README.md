# Toybox Laravel (v5.1, v5.2 and v5.3 with Apache2)

This is a Dockerfile for running several versions of the Laravel PHP Framework.

## Contents in this container

* Apache 2.4
* PHP 5.6 or PHP7.0 with several extentions
* Laravel framework 5.1, 5.2 or 5.3
* [composer](https://getcomposer.org/)
* [node.js](https://nodejs.org/en/)
* [gulp](http://gulpjs.com/)

## Running container with SQLite

This is the simplest way to run Laravel container.

``docker-compose.yml`` example below.

```bash
version: '2'
services:
    laravel:
        image: nutsllc/toybox-laravel:5.3-php7.0-apache
        environment:
            - ALL_PHP_MODULES=enable
            - DB_CONNECTION=sqlite
        volumes:
            - "./laravel:/var/www/laravel"
        ports:
            - 8080:80
```

### PHP and Laravel version

You can select PHP and Laravel version by image tag.

* ``5.3-php5.6-apache`` for Laravel5.3 on Apache2 with PHP5.6
* ``5.3-php7.0-apache`` for Laravel5.3 on Apache2 with PHP7.0
* ``5.2-php5.6-apache`` for Laravel5.2 on Apache2 with PHP5.6
* ``5.2-php7.0-apache`` for Laravel5.2 on Apache2 with PHP7.0
* ``5.1-php5.6-apache`` for Laravel5.1 on Apache2 with PHP5.6
* ``5.1-php7.0-apache`` for Laravel5.1 on Apache2 with PHP7.0

### Environment variables

* ``ALL_PHP_MODULES=enable`` for loading all PHP modules
* ``DB_CONNECTION=sqlite`` for using SQLite database

If you set ``sqlite`` to ``DB_CONNECTION``, it will make database file ``/database/database.sqlite``

## Running container with MariaDB

``docker-compose.yml`` example below.

```bash
version: '2'
services:
    laravel:
        image: nutsllc/toybox-laravel:5.3-php7.0-apache
        environment:
            - ALL_PHP_MODULES=enable
            - DB_HOST=mariadb
            - DB_USERNAME=root
            - DB_PASSWORD=root
        volumes:
            - "./laravel:/var/www/laravel"
        ports:
            - 8080:80
 
    mariadb:
        image: nutsllc/toybox-mariadb
        environment:
            - MYSQL_ROOT_PASSWORD=root
        volumes:
            - "./mariadb:/var/lib/mysql"
```

### Environment Variables

* ``ALL_PHP_MODULES=enable`` for loading all PHP modules
* ``MYSQL_ROOT_PASSWORD=password`` for setting root password
* ``MYSQL_DATABASE=laradb`` for creating database named laradb
* ``MYSQL_USER=lara`` for creating user of the laradb database
* ``MYSQL_PASSWORD=password`` for setting password for user:lara

## Enviroment variables

### General Laravel settings

|Environment variable|Default value|Description|
|:---|:---|:---|
|``LARAVEL_TZ``|UTC|Timezone for Laravel|
|``LARAVEL_LOCALE``|en|locale for Laravel|

### Laravel database settings

These enviroment value will reflect '.env' file.

|Environment variable|Default value|Description|
|:---|:---|:---|
|``DB_CONNECTION``|mysql|Database that is used by Laravel|
|``DB_HOST``|127.0.0.1|IP address or host name of the database|
|``DB_PORT``|3306|Listening port number of the database|
|``DB_DATABASE``|homestead|Database name to store laravel data|
|``DB_USERNAME``|homestead|User name to connect to database|
|``DB_PASSWORD``|secret|Database password for Laravel|

### Laravel mail settings

These enviroment value will reflect '.env' file.

|Environment variable|Default value|Description|
|:---|:---|:---|
|``MAIL_DRIVER``|smtp|SMTP driver you use|
|``MAIL_HOST``|mailtrap.io|IP address or host name of SMTP server|
|``MAIL_PORT``|2525|Listening port number of SMTP server|
|``MAIL_USERNAME``|null|User name to connect to SMTP server|
|``MAIL_PASSWORD``|null|Database password for SMTP server|
|``MAIL_ENCRYPTION``|null|Database password for SMTP server|


### Loading PHP extensions

PHP extensions can be enabled by environment variables with ``enable`` value.

* ``-e CALENDAR=enable``
* ``-e EXIF=enable``
* ``-e GD=enable``
* ``-e GETTEXT=enable``
* ``-e INTL=enable``
* ``-e MCRYPT=enable``
* ``-e MEMCACHED=enable``
* ``-e MYSQLI=enable``
* ``-e OPCACHE=enable``
* ``-e PDO_MYSQL=enable``
* ``-e PDO_PGSQL=enable``
* ``-e SOCKETS=enable``
* ``-e ZIP=enable``
* ``-e APCU=enable``
* ``-e REDIS=enable``
* ``-e XDEBUG=enable``

If you want to enable all of the modules, you could use ``-e ALL_PHP_MODULES=enable``, no more need other options.

### PHP settings

These enviroment value will reflect 'php.ini' file.

|Environment variable|Default value|
|:---|:---|
|MEMORY_LIMIT|32M|
|POST_MAX_SIZE|16M|
|UPLOAD_MAX_FILESIZE|8M|
|ERROR_REPORTING|E_ALL\|E_STRICT|
|DISPLAY_ERRORS|Off|
|LOG_ERRORS|On|
|ERROR_LOG|/var/log/php_error.log|
|DEFAULT_CHARSET|'UTF-8'|
|MBSTRING_LANGUAGE|Japanese|
|MBSTRING_INTERNAL_ENCODING|UTF-8|
|MBSTRING_ENCODING_TRANSLATION|Off|
|MBSTRING_HTTP_INPUT|pass|
|MBSTRING_HTTP_OUTPUT|pass|
|MBSTRING_DETECT_ORDER|auto|
|EXPOSE_PHP|Off|
|SESSION_HASH_FUNCTION|0|
|SESSION_SAVE_HANDLER|files|
|SESSION_SAVE_PATH|'/var/lib/php/session'|
|SHORT_OPEN_TAG|On|
|MAX_EXECUTION_TIME|30|
|DATE_TIMEZONE|UTC|