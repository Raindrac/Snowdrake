#!/bin/bash
set -euox pipefail

nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /iso/nixos/config/disko-configuration.nix
nixos-generate-config --no-filesystems --root /mnt
rm "/mnt/etc/nixos/configuration.nix"
cp -r --no-target-directory "/iso/nixos" "/mnt/etc/nixos/"
mv "/mnt/etc/nixos/hardware-configuration.nix" "/mnt/etc/nixos/config/hardware-configuration.nix"

nixos-install --no-root-password --flake "/mnt/etc/nixos/#Porygon"
echo -e "Don't forget to run \033[1;36mnixos-enter --root /mnt -c 'passwd alice'\033[0m"