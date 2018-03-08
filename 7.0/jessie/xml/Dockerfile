FROM php:7.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y libxml2-dev && \
    docker-php-ext-install xml simplexml dom \
    && php -m | grep xml
