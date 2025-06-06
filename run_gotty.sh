#!/bin/bash

PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

echo "=========================================="
echo "🔒 Gotty Web Terminal Password: $PASSWORD"
echo "=========================================="

exec /usr/local/bin/gotty --reconnect --permit-write --credential "admin:$PASSWORD" /bin/bash
