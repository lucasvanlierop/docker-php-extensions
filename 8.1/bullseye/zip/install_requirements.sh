#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libzip-dev=1.7.3-1 \
unzip=6.0-26 && \
rm -rf /var/lib/apt/lists/*
