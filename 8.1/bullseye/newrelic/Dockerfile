FROM php:8.1-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L "https://download.newrelic.com/php_agent/release/newrelic-php5-$(cat /extension/version)-linux.tar.gz" --output /tmp/newrelic.tar.gz \
	&& tar -xf newrelic.tar.gz \
	&& cd newrelic-* \
    && NR_INSTALL_SILENT=true ./newrelic-install install \
	&& cp "$(php -r "echo ini_get ('extension_dir');")/newrelic.so" /extension \
	&& rm -rf /tmp/newrelic*

COPY ./install* /extension/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
