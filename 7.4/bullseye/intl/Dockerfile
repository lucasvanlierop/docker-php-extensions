FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libicu-dev=67.1-7 && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install intl && \
  cp $(php -r "echo ini_get ('extension_dir');")/intl.so ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/