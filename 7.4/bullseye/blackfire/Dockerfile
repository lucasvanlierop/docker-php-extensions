FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN bash -c "$(curl -L https://installer.blackfire.io/installer.sh)"

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
