FROM php:7.1.5-fpm-alpine

RUN apk update \

# Install PHP Mongo extension
    && apk add \
    --virtual .mongodb-ext-build-deps \
        autoconf \
        openssl-dev \
        g++ \
        make \
    && pecl install mongo \
    && docker-php-ext-enable mongo \
    && apk del .mongodb-ext-build-deps
