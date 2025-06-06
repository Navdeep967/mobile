#!/bin/bash

# Generate a random 10-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

echo "=========================================="
echo "🔒 Gotty Web Terminal Password: $PASSWORD"
echo "=========================================="

# Start tmate in the background with no shell (-F means don't fork)
tmate -S /tmp/tmate.sock new-session -d

# Wait for tmate to initialize and print SSH connection info
echo "⏳ Waiting for tmate SSH session to be ready..."
sleep 2

# Fetch and print tmate SSH and Web URLs (retry a few times)
for i in {1..10}; do
    TMATE_SSH=$(tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}')
    TMATE_WEB=$(tmate -S /tmp/tmate.sock display -p '#{tmate_web}')
    if [[ -n "$TMATE_SSH" && -n "$TMATE_WEB" ]]; then
        break
    fi
    sleep 1
done

echo "=========================================="
echo "🔗 tmate SSH Link: $TMATE_SSH"
echo "🌐 tmate Web Link: $TMATE_WEB"
echo "=========================================="

# Start Gotty (foreground) with password protection
exec /usr/local/bin/gotty --permit-write --reconnect --credential "admin:$PASSWORD" /bin/bash
