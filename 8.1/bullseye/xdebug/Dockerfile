FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L "https://github.com/xdebug/xdebug/archive/refs/tags/$(cat /extension/version).tar.gz" --output /tmp/xdebug.tar.gz \
    && tar -xf xdebug.tar.gz \
    && cd xdebug-* \
    && phpize \
    && ./configure --enable-xdebug\
    && make \
    && make install \
    && cp ./modules/xdebug.so /extension \
    && rm -rf /tmp/xdebug*

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
