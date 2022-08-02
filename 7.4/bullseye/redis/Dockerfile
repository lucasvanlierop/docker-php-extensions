FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L "https://github.com/phpredis/phpredis/archive/refs/tags/$(cat /extension/version).tar.gz" --output /tmp/redis.tar.gz \
    && tar -xf redis.tar.gz \
    && cd phpredis-* \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cp ./modules/redis.so /extension \
    && rm -rf /tmp/redis*

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
