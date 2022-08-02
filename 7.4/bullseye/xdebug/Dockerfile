FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

# Install APCU PHP extensions
RUN cd /tmp \
    && export VERSION=$(cat /extension/version) \
    && curl -L https://github.com/xdebug/xdebug/archive/refs/tags/${VERSION}.tar.gz --output /tmp/xdebug.tar.gz \
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
