FROM ubuntu:22.04

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    PORT=8080

# Install dependencies: code-server, openssh-server, sudo
RUN apt-get update && \
    apt-get install -y curl openssh-server sudo && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user 'coder', add to sudoers (no preset password)
RUN useradd -m coder && adduser coder sudo

# SSHD config: use port 2222, allow password login, disable root login
RUN mkdir /var/run/sshd && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Expose code-server and SSH ports
EXPOSE 8080 2222

# Copy and make the entrypoint script executable
COPY run_combined.sh /run_combined.sh
RUN chmod +x /run_combined.sh

# Switch to coder user
USER coder
WORKDIR /home/coder

# Use bash as entrypoint to support password generation, sshd, code-server
ENTRYPOINT ["/bin/bash", "/run_combined.sh"]
