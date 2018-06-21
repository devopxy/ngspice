FROM alpine:3.7 as build

LABEL maintainer="Mangesh Bhalerao <mangesh {at} devopxy {dot} com >"

ENV NGSPICE_VERSION 28

RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    automake \
    bison \
    curl \
    flex \
    g++ \
    libx11-dev \
    libxaw-dev \
    libtool \
    make \
    && curl -fSL https://github.com/imr/ngspice/archive/ngspice-$NGSPICE_VERSION.tar.gz -o ngspice.tar.gz \
    && mkdir -p /usr/src \
    && tar -zxC /usr/src -f ngspice.tar.gz \
    && rm ngspice.tar.gz \
    && cd /usr/src/ngspice-ngspice-$NGSPICE_VERSION \
    && ./autogen.sh \
    && ./configure \
    && make && make install \
    && rm -rf  /usr/src/ngspice-ngspice-$NGSPICE_VERSION \
    && apk del .build-deps \
    && apk add --no-cache libx11 libxaw
