FROM php:7.1.5-fpm-alpine

RUN apk update \

# Install PHP Zip extension
    && apk add zlib-dev \
    && docker-php-ext-install -j "$(nproc)" zip
