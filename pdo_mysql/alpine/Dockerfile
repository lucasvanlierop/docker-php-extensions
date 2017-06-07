FROM php:7.1.5-fpm-alpine

RUN apk update \

# Install PHP PDO MySQL extension
    && docker-php-ext-install -j "$(nproc)" pdo_mysql
