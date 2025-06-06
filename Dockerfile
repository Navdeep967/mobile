FROM ubuntu:22.04

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    PORT=8080

# Install dependencies and code-server
RUN apt-get update && \
    apt-get install -y curl openssh-server sudo && \
    curl -fsSL https://code-server.dev/install.sh | sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create user 'coder', add to sudoers
RUN useradd -m coder && echo 'coder:coder' | chpasswd && adduser coder sudo

# Setup SSH config: port 2222, allow password login, disable root login
RUN mkdir /var/run/sshd && \
    sed -i 's/#Port 22/Port 2222/' /etc/ssh/sshd_config && \
    echo "PermitRootLogin no" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Generate SSH host keys (required)
RUN ssh-keygen -A

# Expose code-server and SSH ports
EXPOSE 8080 2222

# Copy the startup script
COPY run_combined.sh /run_combined.sh
RUN chmod +x /run_combined.sh

# Remain as root to allow password manipulation, drop privileges later
WORKDIR /home/coder

CMD ["/bin/bash", "/run_combined.sh"]
