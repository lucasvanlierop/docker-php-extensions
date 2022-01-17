FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libpng-dev \
    libjpeg62-turbo-dev && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
	--with-freetype=/usr \
	--with-jpeg=/usr

RUN docker-php-ext-install gd && \
    cp $(php -r "echo ini_get ('extension_dir');")/gd.so ./ \

COPY ./install* ./

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
