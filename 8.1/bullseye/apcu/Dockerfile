FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L "https://github.com/krakjoe/apcu/archive/refs/tags/v$(cat /extension/version).tar.gz" --output /tmp/apcu.tar.gz \
    && tar -xf apcu.tar.gz \
    && cd apcu-* \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && ls -al \
    && cp ./modules/apcu.so /extension \
    && rm -rf /tmp/apcu*

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
