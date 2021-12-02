FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version version

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    graphicsmagick=1.4+really1.3.36+hg16481-2 \
	libgraphicsmagick1-dev=1.4+really1.3.36+hg16481-2 \
    && rm -rf /var/lib/apt/lists/*


RUN cd /tmp \
    && export VERSION=$(cat /extension/version) \
	&& curl https://pecl.php.net/get/gmagick-$VERSION.tgz --output /tmp/gmagick.tar.gz \
	&& tar zxvf gmagick.tar.gz \
	&& cd gmagick-* \
	&& phpize \
	&& ./configure \
	&& make \
	&& make install \
	&& cp ./modules/gmagick.so /extension \
	&& rm -rf /tmp/gmagick*

COPY install_requirements.sh /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
