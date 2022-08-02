FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install opcache && \
    cp "$(php -r "echo ini_get ('extension_dir');")/opcache.so" ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
