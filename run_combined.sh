#!/bin/bash

# Generate a random 10-character password for Gotty
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

echo "=========================================="
echo "🔒 Gotty Web Terminal Password: $PASSWORD"
echo "=========================================="

# Start Gotty web terminal in the background
/usr/local/bin/gotty --permit-write --reconnect --credential "admin:$PASSWORD" /bin/bash &

# Start code-server (no authentication)
code-server --bind-addr 0.0.0.0:8080 --auth none &

# Wait for both background jobs
wait
