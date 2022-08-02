FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./


RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libc-client-dev \
    libkrb5-dev && \
    rm -rf /var/lib/apt/lists/*

RUN set -eux; \
    PHP_OPENSSL=yes docker-php-ext-configure imap --with-kerberos --with-imap-ssl;

RUN docker-php-ext-install imap && \
  cp $(php -r "echo ini_get ('extension_dir');")/imap.so ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
