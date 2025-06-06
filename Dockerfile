FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git golang-go && \
    git clone https://github.com/sorenisanerd/gotty.git && \
    cd gotty && go get ./... && go build && \
    mv gotty /usr/local/bin/gotty && \
    cd / && rm -rf gotty && \
    apt-get purge --auto-remove -y git golang-go && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy script
COPY run_gotty.sh /run_gotty.sh
RUN chmod +x /run_gotty.sh

EXPOSE 8080
CMD ["/bin/bash", "/run_gotty.sh"]
