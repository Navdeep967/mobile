#!/bin/bash

# Generate a random 10-character password
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)

# Print it to the container log
echo "=========================================="
echo "🔒 ttyd Web Terminal Password: $PASSWORD"
echo "=========================================="

# Start ttyd with password authentication
exec ttyd -p 7681 -c admin:$PASSWORD bash
