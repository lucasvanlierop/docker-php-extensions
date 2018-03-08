FROM php:7.1-alpine

RUN apk add --update --no-cache \
# required for imagemagick
   imagemagick-dev \
# required for installation
   autoconf g++ pcre-dev libtool make \
   && pecl install imagick \
   && docker-php-ext-enable imagick \
   && apk del autoconf g++ libtool make pcre-dev

RUN php -r "echo extension_loaded('imagick')==1?'installed':'oops';"
