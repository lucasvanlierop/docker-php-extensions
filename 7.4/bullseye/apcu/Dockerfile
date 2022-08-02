FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

# Install APCU PHP extensions
RUN cd /tmp \
    && export VERSION=$(cat /extension/version) \
    && curl -L https://github.com/krakjoe/apcu/archive/refs/tags/v${VERSION}.tar.gz --output /tmp/apcu.tar.gz \
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
