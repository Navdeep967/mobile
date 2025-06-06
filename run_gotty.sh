#!/bin/bash

# Generate a random 10-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

echo "=========================================="
echo "🔒 Gotty Web Terminal Password: $PASSWORD"
echo "=========================================="

# Start tmate session in the background
tmate -S /tmp/tmate.sock new-session -d

echo "⏳ Waiting for tmate SSH session to be ready..."
for i in {1..10}; do
    TMATE_SSH=$(tmate -S /tmp/tmate.sock display -p '#{tmate_ssh}' 2>/dev/null)
    TMATE_WEB=$(tmate -S /tmp/tmate.sock display -p '#{tmate_web}' 2>/dev/null)
    
    if [[ -n "$TMATE_SSH" && -n "$TMATE_WEB" ]]; then
        break
    fi
    sleep 1
done

if [[ -z "$TMATE_WEB" ]]; then
    echo "❌ Failed to initialize tmate web session."
else
    echo "=========================================="
    echo "🔗 tmate SSH Link: $TMATE_SSH"
    echo "🌐 tmate Web Link: $TMATE_WEB"
    echo "=========================================="
fi

# Start Gotty in foreground
exec /usr/local/bin/gotty --permit-write --reconnect --credential "admin:$PASSWORD" /bin/bash
