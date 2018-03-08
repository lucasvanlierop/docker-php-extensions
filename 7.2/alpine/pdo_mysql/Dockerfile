FROM php:7.2-fpm-alpine

RUN apk update \

# Install PHP PDO MySQL extension
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) pdo_mysql \
    && php -m | grep pdo_mysql
