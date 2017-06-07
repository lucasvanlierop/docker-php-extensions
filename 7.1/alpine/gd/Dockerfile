FROM php:7.1-fpm-alpine

RUN apk update \

# Install PHP GD extension
    && apk add \
        freetype \
        libpng \
        libjpeg-turbo \
    && apk add \
        --virtual gd_dependencies \
        freetype-dev \
        libpng-dev \
        libjpeg-turbo-dev\
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd \
    && apk del gd_dependencies
