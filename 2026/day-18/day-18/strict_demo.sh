#!/bin/bash
set -euo pipefail

echo "Testing strict mode..."

# Undefined variable (will fail because of -u)
echo "$UNDEFINED_VAR"

# This line won't run because script exits above
echo "This won't print"
