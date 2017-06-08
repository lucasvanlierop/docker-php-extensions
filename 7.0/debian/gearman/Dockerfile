FROM php:7.0-cli

# Install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install PHP Gearman extension
    # Note that Gearman is not PHP 7 compatible yet
    # It can be installed from source though
    && apt-get -y install wget unzip re2c libgearman-dev \
    && mkdir -p /usr/src/php/ext \
    && cd /usr/src/php/ext \
    && wget https://github.com/wcgallego/pecl-gearman/archive/master.zip \
    && unzip master.zip \
    && mv pecl-gearman-master gearman \
    && cd gearman \
    && docker-php-ext-install gearman \
    && apt-get -y remove wget unzip re2c \
    && php -m | grep gearman

