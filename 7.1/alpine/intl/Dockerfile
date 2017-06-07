FROM php:7.1-fpm-alpine

RUN apk update \

# Install PHP Intl extension
    && apk add icu-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) intl

