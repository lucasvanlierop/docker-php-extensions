FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libxml2-dev=2.9.10+dfsg-6.7 && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install soap && \
  cp $(php -r "echo ini_get ('extension_dir');")/soap.so ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/