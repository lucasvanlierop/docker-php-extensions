#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libc-client2007e && \
rm -rf /var/lib/apt/lists/*