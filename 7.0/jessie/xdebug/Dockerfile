FROM php:7.0

ENV PHP_EXT_XDEBUG_INSTALL_ONLY_DEPENDENCIES='\
    autoconf \
    g++ \
    make \
    '

RUN apt-get update \
    && apt-get install -y \
        ${PHP_EXT_XDEBUG_INSTALL_ONLY_DEPENDENCIES} \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && apt-get remove -y \
        ${PHP_EXT_XDEBUG_INSTALL_ONLY_DEPENDENCIES}
