FROM php:7.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y libicu-dev && \
    docker-php-ext-install intl \
    && php -m | grep intl
