FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L "https://github.com/igbinary/igbinary/archive/refs/tags/$(cat /extension/version).tar.gz" --output /tmp/igbinary.tar.gz \
    && tar -xf igbinary.tar.gz \
    && cd igbinary-* \
    && phpize \
    && ./configure CFLAGS="-O2 -g" --enable-igbinary \
    && make \
    && make install \
    && cp ./modules/igbinary.so /extension \
    && rm -rf /tmp/igbinary*

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
