#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libzip-dev=1.7.3-1 && \
rm -rf /var/lib/apt/lists/*
