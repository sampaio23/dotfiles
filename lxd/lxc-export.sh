#!/usr/bin/env bash
set -e

# Get the directory where this script lives, then point to the profiles subfolder
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILES_DIR="$SCRIPT_DIR/profiles"

mkdir -p "$PROFILES_DIR"

echo "=== Exporting LXD Profiles ==="

for profile in $(lxc profile list --format csv -c n); do
    echo "Processing: $profile"
    
    # Export profile and strip out the host-specific 'used_by' block
    lxc profile show "$profile" | sed '/^used_by:/,$d' > "$PROFILES_DIR/$profile.yaml"
done

echo "=== Done! Profiles cleaned and saved to $PROFILES_DIR ==="
