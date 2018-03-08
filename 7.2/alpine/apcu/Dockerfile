FROM php:7.2-alpine

# Install APCU PHP extensions
RUN apk --update --no-cache add \
        pcre-dev \
        --virtual .phpize-deps $PHPIZE_DEPS \
            autoconf \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && apk del .phpize-deps \
    && php -m | grep 'apcu'
