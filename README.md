# Toybox Laravel (v5.1, v5.2 and v5.3 with Apache2)

This is a Dockerfile for running several versions of the Laravel PHP Framework.

If you would like to have Nginx with PHP-FPM environment to run Laravel, visit [Toybox Laravel Data](https://github.com/nutsllc/toybox-laravel-data) repository.

## Running Laravel container

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
            - "./data/laravel:/var/www/laravel"
        ports:
            - 8080:80
```

### Image tags

* ``5.3-php5.6-apache`` for Laravel5.3 on Apache2 with PHP5.6
* ``5.3-php7.0-apache`` for Laravel5.3 on Apache2 with PHP7.0
* ``5.2-php5.6-apache`` for Laravel5.2 on Apache2 with PHP5.6
* ``5.2-php7.0-apache`` for Laravel5.2 on Apache2 with PHP7.0
* ``5.1-php5.6-apache`` for Laravel5.1 on Apache2 with PHP5.6
* ``5.1-php7.0-apache`` for Laravel5.1 on Apache2 with PHP7.0

### Environment variables

* ``ALL_PHP_MODULES=enable`` for loading all PHP modules
* ``DB_CONNECTION=sqlite`` for using SQLite database

## Running Laravel container with MariaDB (MySQL)

``docker-compose.yml`` example below.

```bash
version: '2'
services:
    laravel:
        image: nutsllc/toybox-laravel:5.3-php7.0-apache
        environment:
            - ALL_PHP_MODULES=enable
        volumes:
            - "./data/laravel:/var/www/laravel"
        ports:
            - 8080:80
 
    mariadb:
        image: nutsllc/toybox-mariadb
        environment:
            - MYSQL_ROOT_PASSWORD=root
            - MYSQL_DATABASE=laradb
            - MYSQL_USER=lara
            - MYSQL_PASSWORD=password
        volumes:
            - "./data/mysql:/var/lib/mysql"
```

### Environment Variables

* ``ALL_PHP_MODULES=enable`` for loading all PHP modules
* ``MYSQL_ROOT_PASSWORD=password`` for setting root password
* ``MYSQL_DATABASE=laradb`` for creating database named laradb
* ``MYSQL_USER=lara`` for creating user of the laradb database
* ``MYSQL_PASSWORD=password`` for setting password for user:lara

## Change configuration values of the Laravel

|Environment variavle|Default value|Description|
|:---|:---|:---|
|``DB_CONNECTION``|mysql|Database that is used by Laravel|
|``DB_HOST``|mariadb|IP address or host name of the database|
|``DB_PORT``|3306|Listening port number of the database|
|``DB_DATABASE``|laradb|Database name to store laravel data|
|``DB_USERNAME``|lara|User name to connect to database|
|``DB_PASSWORD``|password|Database password for Laravel|
|``LARAVEL_TZ``|UTC|Timezone for Laravel|
|``LARAVEL_LOCALE``|en|locale for Laravel|

## Enabling PHP extensions

PHP extensions can be enabled by environment variables with ``enable`` value.

For example:

``docker run -itd -p 8080:80 -e GD=enable -e MEMCACHED=enable -e APCU=enable -e OPCACHE=enable -e XDEBUG=true -d nutsllc/toybox-aravel:5.3-php7.0-apache``

### List of the PHP extensions that you can enable to container

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

## Change php.ini parameter values

Parameter values in php.ini can be changed by environment variables with new value.

For example:

``docker run -itd -p 8080:80 -e MEMORY_LIMIT=64M -e POST_MAX_SIZE=32M -e UPLOAD_MAX_FILESIZE=8M -d nutsllc/toybox-laravel:5.3-php7.0-apache``

### List of the php.ini paramaters that you can change

Values list below are a default value.

* ``-e MEMORY_LIMIT="32M"``
* ``-e POST_MAX_SIZE="16M"``
* ``-e UPLOAD_MAX_FILESIZE="8M"``
* ``-e ERROR_REPORTING="E_ALL|E_STRICT"``
* ``-e DISPLAY_ERRORS="Off"``
* ``-e LOG_ERRORS="On"``
* ``-e ERROR_LOG="/var/log/php_error.log"``
* ``-e DEFAULT_CHARSET="'UTF-8'"``
* ``-e MBSTRING_LANGUAGE="Japanese"``
* ``-e MBSTRING_INTERNAL_ENCODING="UTF-8"``
* ``-e MBSTRING_ENCODING_TRANSLATION="Off"``
* ``-e MBSTRING_HTTP_INPUT="pass"``
* ``-e MBSTRING_HTTP_OUTPUT="pass"``
* ``-e MBSTRING_DETECT_ORDER="auto"``
* ``-e EXPOSE_PHP="Off"``
* ``-e SESSION_HASH_FUNCTION="0"``
* ``-e SESSION_SAVE_HANDLER="files"``
* ``-e SESSION_SAVE_PATH="'/var/lib/php/session'"``
* ``-e SHORT_OPEN_TAG="On"``
* ``-e MAX_EXECUTION_TIME="30"``
* ``-e DATE_TIMEZONE="UTC"``


