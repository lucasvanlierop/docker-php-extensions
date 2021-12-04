FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN docker-php-ext-install bcmath && \
  cp $(php -r "echo ini_get ('extension_dir');")/bcmath.so ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/