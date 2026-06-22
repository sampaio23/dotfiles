#!/usr/bin/env bash
set -e

# Get the directory where this script lives, then point to the profiles subfolder
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_DIR="$SCRIPT_DIR/profiles"

if [ ! -d "$PROFILES_DIR" ] || [ -z "$(ls -A "$PROFILES_DIR" 2>/dev/null)" ]; then
    echo "Error: No profiles found in $PROFILES_DIR"
    exit 1
fi

echo "=== Importing LXD Profiles ==="

for file in "$PROFILES_DIR"/*.yaml; do
    profile_name=$(basename "$file" .yaml)
    echo "Applying: $profile_name"
    
    # Create the profile if it doesn't exist yet on this host
    lxc profile create "$profile_name" 2>/dev/null || true
    
    # Import the clean configuration
    lxc profile edit "$profile_name" < "$file"
done

echo "=== Done! All profiles successfully synchronized ==="
