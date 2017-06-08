FROM php:7.0-cli

# Install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install PHP PDO MySql extension
    && docker-php-ext-install pdo_mysql \
    && php -m | grep pdo_mysql


