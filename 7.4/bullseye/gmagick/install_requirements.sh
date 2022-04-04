#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
libbsd-dev && \
libgraphicsmagick-q16-3 \
rm -rf /var/lib/apt/lists/*

DIR=$(dirname "$(readlink -f "$0")")

cp -P "$DIR"/lib/*.so* /usr/lib/x86_64-linux-gnu
cp "$DIR"/bin/gm /usr/local/bin/
