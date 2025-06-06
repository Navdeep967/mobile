FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV DEBIAN_FRONTEND=noninteractive

# Install ttyd and bash
RUN apt-get update && \
    apt-get install -y wget curl git build-essential cmake pkg-config libjson-c-dev libwebsockets-dev bash && \
    git clone https://github.com/tsl0922/ttyd.git && \
    cd ttyd && mkdir build && cd build && \
    cmake .. && make && make install && \
    cd / && rm -rf ttyd && \
    apt-get purge --auto-remove -y build-essential cmake git wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the startup script
COPY run_ttyd.sh /run_ttyd.sh
RUN chmod +x /run_ttyd.sh

EXPOSE 7681
CMD ["/bin/bash", "/run_ttyd.sh"]
