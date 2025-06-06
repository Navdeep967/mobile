FROM ubuntu:22.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    GOTTY_TAG_VER=v1.0.1 \
    PORT=8080

# Install dependencies and code-server
RUN apt-get update && \
    apt-get install -y curl wget gnupg software-properties-common tar && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    wget -O /tmp/gotty.tar.gz "https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz" && \
    tar -xzvf /tmp/gotty.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/gotty && \
    rm /tmp/gotty.tar.gz && \
    apt-get purge --auto-remove -y curl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY run_combined.sh /run_combined.sh
RUN chmod +x /run_combined.sh

EXPOSE 8080

CMD ["/bin/bash", "/run_combined.sh"]
