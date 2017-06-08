FROM php:7.0-cli

# Install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install PHP bcmath
    && docker-php-ext-install bcmath \
    && php -m | grep bcmath

