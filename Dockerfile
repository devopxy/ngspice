FROM alpine:3.7 as build

LABEL maintainer="Mangesh Bhalerao <mangesh {at} devopxy {dot} com >"

ENV NGSPICE_VERSION 28

RUN echo $NGSPICE_VERSION

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
    make

RUN curl -fSL https://github.com/imr/ngspice/archive/ngspice-$NGSPICE_VERSION.tar.gz -o ngspice.tar.gz \
    && mkdir -p /usr/src \
    && tar -zxC /usr/src -f ngspice.tar.gz \
    && rm ngspice.tar.gz \
    && cd /usr/src/ngspice-ngspice-$NGSPICE_VERSION \
    && ./autogen.sh \
    && ./configure --prefix=/usr/local\
    && make && make install 
    
FROM alpine:3.7 as final
    
COPY --from=build /usr/local /usr/local
    
USER ngspice
