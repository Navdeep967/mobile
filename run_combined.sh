#!/bin/bash

# Generate a random 12-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)

# Set password for coder (SSH and sudo)
echo "coder:$PASSWORD" | chpasswd

echo "=========================================="
echo "🔑 SSH & code-server password: $PASSWORD"
echo "=========================================="

# Start SSHD in the background
/usr/sbin/sshd -D &

# Set password env var for code-server
export PASSWORD="$PASSWORD"

# Start code-server (no --password argument, use $PASSWORD)
sudo -u coder -E code-server --bind-addr 0.0.0.0:8080 --auth password
