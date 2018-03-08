FROM php:7.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install PHP MCrypt extension
    && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt \
    && php -m | grep mcrypt

