FROM debian:forky-slim AS build

ARG BUILD_DIR=/build

RUN apt-get -y update \
    && apt-get -y --no-install-recommends install \
        curl \
        ca-certificates \
        build-essential \
        cmake \
        git \
        libusb-1.0-0-dev \
        libsoapysdr-dev

WORKDIR ${BUILD_DIR}
RUN git clone https://github.com/BertoldVdb/libmirisdr-6.git \
    && cd  libmirisdr-6 \
    && mkdir build && cd build \
    && cmake .. && make && make install

FROM debian:forky-slim

# install the compiled binaries from the build stage
COPY --from=build /usr/local /usr/local

# install the container entrypoint
COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

RUN apt-get -y update \
    && apt-get -y --no-install-recommends install \
        curl \
        ca-certificates \
        dbus \
        avahi-daemon \
        libusb-1.0-0 \
        soapysdr-tools\
        soapysdr-module-all \
        soapyremote-server \
        tini \
    && find /usr/lib -type f -name 'libmiriSupport.so' -print -delete \
    && ldconfig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 

ENTRYPOINT [ "/usr/bin/tini", "--", "/etc/entrypoint.sh" ]

EXPOSE 55132
