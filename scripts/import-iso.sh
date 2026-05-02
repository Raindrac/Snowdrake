#!/bin/bash
set -euox pipefail
OUTPUT_OWNER=Raindrop

# No checks for now. Just rely on normal errors, it'll fail before bad things happen.
nix build .#nixosConfigurations.iso.config.system.build.isoImage
cp -LR ./result ./output
rm ./result
chown -R "$OUTPUT_OWNER" ./output
chmod -R 755 ./output