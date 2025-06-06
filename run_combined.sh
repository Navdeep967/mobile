#!/bin/bash

# Generate a random 12-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)

# Set password for coder (for SSH)
echo "coder:$PASSWORD" | chpasswd

echo "=========================================="
echo "🔑 SSH & code-server password: $PASSWORD"
echo "=========================================="

# Start SSHD in the background
/usr/sbin/sshd -D &

# Run code-server as the coder user, passing PASSWORD env var
exec su coder -c "export PASSWORD='$PASSWORD'; code-server --bind-addr 0.0.0.0:8080 --auth password"
