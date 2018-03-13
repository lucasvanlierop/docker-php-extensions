FROM php:7.2-alpine

ENV PHP_EXT_INTL_DEPENDENCIES=icu-dev

RUN apk update \

# Install PHP Intl extension
    && apk add ${PHP_EXT_INTL_DEPENDENCIES} \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) intl \
    && php -m | grep intl

