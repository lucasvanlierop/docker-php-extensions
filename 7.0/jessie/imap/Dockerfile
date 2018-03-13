FROM php:7.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

# Install PHP imap extension
    && apt-get install -y \
        libc-client-dev \
        libkrb5-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && php -m | grep imap
