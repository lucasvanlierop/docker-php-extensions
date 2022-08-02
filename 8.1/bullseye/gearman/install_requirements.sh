#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
    libgearman8=1.1.19.1+ds-2+b2 && \
rm -rf /var/lib/apt/lists/*


