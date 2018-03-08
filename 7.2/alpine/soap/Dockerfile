FROM php:7.2-fpm-alpine

RUN apk update \

# Install PHP SOAP extension
    && apk add \
        libxml2-dev \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) soap \
    && php -m | grep soap
