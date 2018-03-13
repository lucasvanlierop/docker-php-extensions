FROM php:5.6-alpine

ENV PHP_EXT_XDEBUG_INSTALL_ONLY_DEPENDENCIES='\
    autoconf \
    g++ \
    make \
    '

RUN apk update \
    && apk add \
        ${PHP_EXT_XDEBUG_INSTALL_ONLY_DEPENDENCIES} \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del \
        ${PHP_EXT_XDEBUG_INSTALL_ONLY_DEPENDENCIES} \
    && php -m | grep xdebug
