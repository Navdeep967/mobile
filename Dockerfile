FROM ubuntu:20.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

# Prevent tzdata prompt
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install and build patched GoTTY with mobile support
RUN apt-get update && \
    apt-get install -y curl git golang-go && \
    git clone https://github.com/sorenisanerd/gotty.git /opt/gotty && \
    cd /opt/gotty && go get ./... && go build -o /usr/local/bin/gotty && \
    rm -rf /opt/gotty && \
    apt-get purge --auto-remove -y git golang-go && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add startup script
COPY run_gotty.sh /run_gotty.sh
RUN chmod +x /run_gotty.sh

EXPOSE 8080
CMD ["/bin/bash", "/run_gotty.sh"]
