FROM php:7.0

ENV DEBIAN_FRONTEND=noninteractive \
    PHP_EXT_INTL_DEPENDENCIES=libicu-dev

RUN apt-get update && \
    apt-get install -y ${PHP_EXT_INTL_DEPENDENCIES} && \
    docker-php-ext-install intl \
    && php -m | grep intl
