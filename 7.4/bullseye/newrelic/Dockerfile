FROM php:7.4-bullseye as builder

RUN mkdir /extension
WORKDIR /extension

COPY ./version ./

RUN cd /tmp \
    && export VERSION=$(cat /extension/version) \
	&& curl -L https://download.newrelic.com/php_agent/release/newrelic-php5-${VERSION}-linux.tar.gz --output /tmp/newrelic.tar.gz \
	&& tar -xf newrelic.tar.gz \
	&& cd newrelic-* \
    && NR_INSTALL_SILENT=true ./newrelic-install install \
	&& cp $(php -r "echo ini_get ('extension_dir');")/newrelic.so /extension \
	&& rm -rf /tmp/newrelic*

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
