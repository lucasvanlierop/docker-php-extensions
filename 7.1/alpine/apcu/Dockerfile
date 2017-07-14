FROM php:7.1-fpm-alpine

RUN apk update \

# Install APCU PHP extensions
    && apk add \
        pcre-dev \
        --virtual .phpize-deps $PHPIZE_DEPS \
            autoconf \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && apk del .phpize-deps \
    && php -m | grep 'apcu'
