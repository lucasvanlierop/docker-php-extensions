FROM php:5.6-alpine

RUN apk update \

# Install PHP BC math extension
    && docker-php-ext-install bcmath \
    && php -m | grep bcmath
