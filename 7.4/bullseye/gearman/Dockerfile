FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgearman-dev=1.1.19.1+ds-2+b2 && \
    rm -rf /var/lib/apt/lists/*

# Install APCU PHP extensions
RUN cd /tmp \
    && export VERSION=$(cat /extension/version) \
    && curl -L https://github.com/php/pecl-networking-gearman/archive/refs/tags/gearman-${VERSION}.tar.gz --output /tmp/gearman.tar.gz \
    && tar -xf gearman.tar.gz \
    && cd pecl-networking-gearman-gearman-* \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cp ./modules/gearman.so /extension \
    && rm -rf /tmp/gearman*

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
