FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

# Install APCU PHP extensions
RUN cd /tmp \
    && export VERSION=$(cat /extension/version) \
    && curl -L https://github.com/igbinary/igbinary/archive/refs/tags/${VERSION}.tar.gz --output /tmp/igbinary.tar.gz \
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

RUN ls -al /extension
