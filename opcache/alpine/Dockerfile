FROM php:7.1.5-fpm-alpine

RUN apk update \

# Install PHP opcache extension
    && docker-php-ext-install -j "$(nproc)" opcache
