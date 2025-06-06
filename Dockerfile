FROM ubuntu:22.04

# Set environment variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    PORT=8080

# Install dependencies and code-server
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Expose code-server port
EXPOSE ${PORT}

# Use a non-root user for security (recommended)
RUN useradd -m coder
USER coder
WORKDIR /home/coder

# Start code-server with password authentication (change YOUR_PASSWORD)
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password", "--password", "YOUR_PASSWORD"]
