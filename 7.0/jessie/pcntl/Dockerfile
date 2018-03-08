FROM php:7.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install PHP Process control extension
    && docker-php-ext-install pcntl
