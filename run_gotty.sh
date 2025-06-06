#!/bin/bash

# Generate a random 10-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

# Print the password to the container log
echo "=========================================="
echo "🔒 Gotty Web Terminal Password: $PASSWORD"
echo "=========================================="

# Start Gotty with additional flags for mobile/desktop compatibility
exec /usr/local/bin/gotty --permit-write --reconnect --credential "admin:$PASSWORD" \
    --no-clipboard --static-dir /usr/local/share/gotty/static --terminal-size 100x30 /bin/bash
