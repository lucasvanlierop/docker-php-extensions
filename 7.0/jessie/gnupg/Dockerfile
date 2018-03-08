FROM php:7.0

# Install
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \

    # Install GNUPG extension
    && apt-get install -y libgpgme11-dev \
    && pecl install gnupg \
    && docker-php-ext-enable gnupg \
    && php -m | grep gnupg

