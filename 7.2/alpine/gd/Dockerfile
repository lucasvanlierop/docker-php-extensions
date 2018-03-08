FROM php:7.2-fpm-alpine

ENV PHP_EXT_GD_DEPENDENCIES=' \
    freetype \
    libpng \
    libjpeg-turbo \
    ' \
    PHP_EXT_GD_INSTALL_ONLY_DEPENDENCIES=' \
      freetype-dev \
      libpng-dev \
      libjpeg-turbo-dev \
      '

RUN apk add --update --no-cache \
        ${PHP_EXT_GD_DEPENDENCIES} \
        ${PHP_EXT_GD_INSTALL_ONLY_DEPENDENCIES} \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) gd \
    && apk del ${PHP_EXT_GD_INSTALL_ONLY_DEPENDENCIES} \
    && php -m | grep gd
