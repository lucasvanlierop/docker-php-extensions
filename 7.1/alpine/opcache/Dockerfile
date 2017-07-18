FROM php:7.1-fpm-alpine

RUN apk update \

# Install PHP Opcache extension
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) opcache \
    && php -m | grep 'Zend OPcache'
