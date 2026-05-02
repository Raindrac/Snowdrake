#!/bin/bash
set -euox pipefail

nixos-install --no-root-password --flake "/mnt/etc/nixos/#Porygon"
echo -e "Don't forget to run \033[1;36mnixos-enter --root /mnt -c 'passwd alice'\033[0m"