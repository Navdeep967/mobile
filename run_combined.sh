#!/bin/bash

# Generate a random 12-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)

# Set password for coder (SSH and sudo)
echo "coder:$PASSWORD" | chpasswd

echo "=========================================="
echo "🔑 SSH & code-server password: $PASSWORD"
echo "=========================================="

# Start SSHD in the background (in foreground with -D for Docker best practice)
/usr/sbin/sshd -D &

# Start code-server with password auth and the same password
code-server --bind-addr 0.0.0.0:8080 --auth password --password "$PASSWORD"
