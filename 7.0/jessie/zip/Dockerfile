FROM php:7.0

# Install
ENV DEBIAN_FRONTEND=noninteractive \
    PHP_EXT_ZIP_DEPENDENCIES=zlib1g-dev

RUN apt-get update \
    && apt-get install -y ${PHP_EXT_ZIP_DEPENDENCIES} \
    && docker-php-ext-install zip && php -m | grep zip

