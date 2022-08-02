FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libxml2-dev && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install soap && \
    cp "$(php -r "echo ini_get ('extension_dir');")/soap.so" ./
COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
