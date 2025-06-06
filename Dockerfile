
FROM ubuntu:22.04
LABEL maintainer="wingnut0310 <wingnut0310@gmail.com>"

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    GOTTY_TAG_VER=v1.0.1 \
    PORT=8080

# Install dependencies and code-server
RUN apt-get update && \
    apt-get install -y curl wget gnupg software-properties-common && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    # Download Gotty binary and install it
    wget -O /usr/local/bin/gotty "https://github.com/yudai/gotty/releases/download/${GOTTY_TAG_VER}/gotty_linux_amd64" && \
    chmod +x /usr/local/bin/gotty && \
    apt-get purge --auto-remove -y curl wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the combined startup script
COPY run_combined.sh /run_combined.sh
RUN chmod +x /run_combined.sh

EXPOSE ${PORT}

CMD ["/bin/bash", "/run_combined.sh"]
