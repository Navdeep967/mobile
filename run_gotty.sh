#!/bin/bash

# Generate a random password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

echo "=========================================="
echo "🔒 GoTTY Web Terminal Password: $PASSWORD"
echo "🔗 Open http://<your-ip>:8080 and login with:"
echo "   Username: admin"
echo "   Password: $PASSWORD"
echo "=========================================="

# Start GoTTY with write access and login protection
exec /usr/local/bin/gotty \
  --reconnect \
  --permit-write \
  --credential "admin:$PASSWORD" \
  /bin/bash
