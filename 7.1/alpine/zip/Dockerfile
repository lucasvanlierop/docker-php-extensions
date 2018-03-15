FROM php:7.1-alpine

ENV PHP_EXT_ZIP_DEPENDENCIES=zlib-dev

RUN apk update \
    && apk add ${PHP_EXT_ZIP_DEPENDENCIES} \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) zip && php -m | grep zip
