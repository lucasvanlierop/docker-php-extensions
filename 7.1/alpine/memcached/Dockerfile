FROM php:7.1-fpm-alpine

RUN apk update \

# Install PHP Memcached extension
    # Note that memcached is not PHP 7 compatible yet
    # It can be installed from source though
    # https://serverpilot.io/community/articles/how-to-install-the-php-memcache-extension.html
    # Clone source and remove git immediately afterwards
    && apk add git \
    && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
    && apk del git \
    # Install Memcached and extension
    && apk add \
        cyrus-sasl-dev \
        libmemcached-dev \
        zlib-dev \
    && docker-php-ext-install memcached \
    && php -m | grep memcached
