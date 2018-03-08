FROM php:5.6-alpine

RUN apk update \

# Install PHP Process control extension
    && docker-php-ext-install pcntl \
    && php -m | grep pcntl
