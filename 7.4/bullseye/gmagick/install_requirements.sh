#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
graphicsmagick=1.4+really1.3.36+hg16481-2 && \
rm -rf /var/lib/apt/lists/*


