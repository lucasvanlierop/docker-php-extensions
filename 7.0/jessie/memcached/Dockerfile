FROM php:7.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install PHP Memcached extension
    # Note that memcached is not PHP 7 compatible yet
    # It can be installed from source though
    # https://serverpilot.io/community/articles/how-to-install-the-php-memcache-extension.html
    # Clone source and remove git immediately afterwards
    && apt-get install -y git \
    && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
    && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
    && apt-get purge -y git \
    # Install Memcached and extension
    && apt-get install -y libmemcached-dev zlib1g-dev \
    && docker-php-ext-configure memcached \
    && docker-php-ext-install memcached \
    && php -m | grep memcached
