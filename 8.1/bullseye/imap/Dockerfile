FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libc-client-dev \
    libkrb5-dev && \
    rm -rf /var/lib/apt/lists/*

RUN PHP_OPENSSL=yes \
    docker-php-ext-configure imap --with-kerberos --with-imap-ssl

RUN docker-php-ext-install imap && \
    cp "$(php -r "echo ini_get ('extension_dir');")/imap.so" ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
