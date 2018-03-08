FROM php:7.2-fpm-alpine

RUN apk update \

# Install PHP Xdebug extension
    && apk add \
    --virtual .build-dependencies \
        autoconf \
        g++ \
        make \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apk del .build-dependencies \
    && php -m | grep xdebug
