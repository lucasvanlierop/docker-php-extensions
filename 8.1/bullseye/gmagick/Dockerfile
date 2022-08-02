FROM php:7.4-bullseye as builder

WORKDIR /extension

COPY ./version ./

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cmake \
    automake \
    libtool \
    libgraphicsmagick1-dev \
    libopenjp2-7 \
    libopenjp2-7-dev \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L https://github.com/jasper-software/jasper/releases/download/version-3.0.3/jasper-3.0.3.tar.gz --output /tmp/jasper.tar.gz \
    && tar zxvf jasper.tar.gz \
    && cd jasper-* \
    && mkdir cmake \
    && cmake -H./ -B./cmake \
    && cmake --build ./cmake \
    && cmake --build ./cmake --target install \
    && rm -rf /tmp/jasper*

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L https://github.com/strukturag/libde265/releases/download/v1.0.8/libde265-1.0.8.tar.gz --output /tmp/libde265.tar.gz \
    && tar zxvf libde265.tar.gz \
    && cd libde265-* \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/libde265*

# hadolint ignore=DL3003
RUN cd /tmp \
    && curl -L https://github.com/strukturag/libheif/releases/download/v1.12.0/libheif-1.12.0.tar.gz --output /tmp/libheif.tar.gz \
    && tar zxvf libheif.tar.gz \
    && cd libheif-* \
    && ./autogen.sh \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/libheif*

# hadolint ignore=DL3003,SC2002,DL4006
RUN cd /tmp \
    && curl "https://pecl.php.net/get/gmagick-$(cat /extension/version | cut -d- -f1).tgz" --output /tmp/gmagick.tar.gz \
    && tar zxvf gmagick.tar.gz \
    && cd gmagick-* \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && cp ./modules/gmagick.so /extension \
    && rm -rf /tmp/gmagick*

# hadolint ignore=DL3003,SC2002,DL4006
RUN cd /tmp \
    && curl -L "https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/$(cat /extension/version | cut -d- -f2)/GraphicsMagick-$(cat /extension/version | cut -d- -f2).tar.gz" --output /tmp/GraphicsMagick.tar.gz \
    && tar zxvf GraphicsMagick.tar.gz \
    && cd GraphicsMagick-* \
    && ./configure --disable-installed --with-jp2=yes --with-quantum-depth=16 --enable-shared=yes --disable-static \
    && make DESTDIR=/GraphicsMagick install \
    && rm -rf /tmp/GraphicsMagick*

COPY ./install* /extension/

WORKDIR /extension

RUN mkdir lib bin
RUN cp /usr/lib/x86_64-linux-gnu/libjbig.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libwebp.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libwebpmux.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/liblcms2.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libtiff.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libfreetype.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libpng16.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libwmflite.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libXext.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libSM.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libICE.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libX11.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/liblzma.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/liblzma.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libxcb.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libXau.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libXdmcp.so ./lib
RUN cp /usr/lib/x86_64-linux-gnu/libdeflate.so ./lib
RUN cp /usr/local/lib/libde265.so ./lib
RUN cp /usr/local/lib/libheif.so ./lib
RUN cp /usr/local/lib/libjasper.so ./lib

RUN cp /GraphicsMagick/usr/local/lib/*.so ./lib
RUN mv ./lib/libGraphicsMagick.so ./lib/libGraphicsMagick.so.3
RUN ln -s ./libGraphicsMagick.so.3 ./lib/libGraphicsMagick.so.2
RUN ln -s ./libGraphicsMagick.so.3 ./lib/libGraphicsMagick.so

RUN ln -s ./libGraphicsMagick.so.3 ./lib/libGraphicsMagick-Q16.so.3
RUN ln -s ./libGraphicsMagick.so-Q16.3 ./lib/libGraphicsMagick-Q16.so.2
RUN ln -s ./libGraphicsMagick.so-Q16.3 ./lib/libGraphicsMagick-Q16.so

RUN mv ./lib/libGraphicsMagickWand.so ./lib/libGraphicsMagickWand.so.3
RUN ln -s ./libGraphicsMagickWand.so.3 ./lib/libGraphicsMagickWand.so.2
RUN ln -s ./libGraphicsMagickWand.so.3 ./lib/libGraphicsMagickWand.so

RUN ln -s ./libGraphicsMagickWand.so.3 ./lib/libGraphicsMagickWand-Q16.so.3
RUN ln -s ./libGraphicsMagickWand-Q16.so.3 ./lib/libGraphicsMagickWand-Q16.so.2
RUN ln -s ./libGraphicsMagickWand-Q16.so.3 ./lib/libGraphicsMagickWand-Q16.so

RUN cp /GraphicsMagick/usr/local/bin/gm /extension/bin/

FROM alpine:3.15.0
COPY --from=builder /extension/ /extension/
