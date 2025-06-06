#!/bin/bash

# Generate a random 10-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

echo "=========================================="
echo "🔒 Gotty Web Terminal Password: $PASSWORD"
echo "=========================================="

# Start both Gotty and code-server
# Use `&` to run them in background and `wait` to keep container alive
/usr/local/bin/gotty --permit-write --reconnect --credential "admin:$PASSWORD" /bin/bash &

code-server --bind-addr 0.0.0.0:8080 --auth none &

# Wait for background processes
wait
