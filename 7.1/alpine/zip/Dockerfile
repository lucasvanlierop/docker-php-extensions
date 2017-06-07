FROM php:7.1-fpm-alpine

RUN apk update \

# Install PHP Zip extension
    && apk add zlib-dev \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) zip

