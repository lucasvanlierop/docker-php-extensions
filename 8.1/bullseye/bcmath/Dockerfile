FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install bcmath && \
    cp "$(php -r "echo ini_get ('extension_dir');")/bcmath.so" ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
