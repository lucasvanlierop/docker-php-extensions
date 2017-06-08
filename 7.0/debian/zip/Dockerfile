FROM php:7.0-cli

# Install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install PHP Zip extension
    && apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip \
    && php -m | grep zip

