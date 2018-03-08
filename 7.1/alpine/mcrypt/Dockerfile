FROM php:7.1-alpine

RUN apk update \

# Install PHP Mcrypt extension
    && apk add --no-cache libmcrypt-dev \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) mcrypt \
    && php -m | grep mcrypt
