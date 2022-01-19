#!/bin/bash

apt-get update && \
apt-get install -y --no-install-recommends \
+libfreetype6=2.10.4+dfsg-1 \
+libpng16-16=1.6.37-3 \
+libjpeg62-turbo=1:2.0.6-4 && \
rm -rf /var/lib/apt/lists/*


