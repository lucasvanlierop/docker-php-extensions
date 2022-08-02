FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install pdo_mysql && \
    cp "$(php -r "echo ini_get ('extension_dir');")/pdo_mysql.so" ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
