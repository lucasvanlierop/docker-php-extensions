FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN version=$(cat /extension/version) \
    && architecture=$(uname -m) \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/$architecture/$version \
    && mkdir -p /tmp/blackfire \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp/blackfire \
    && cp /tmp/blackfire/blackfire-*.so /extension \
    && rm -rf /tmp/blackfire /tmp/blackfire-probe.tar.gz

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
