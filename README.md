This is my personal NixOS flake. It's a heavy work in progress, not usable for daily driving yet, but it works.

It boots into Niri and DankMaterialShell; auto-login is currently enabled and I haven't yet figured out why. Steam and Sunshine are pre-installed and `nix-flatpak` will install some flatpaks a while after the first boot.

I'm iterating on this flake in a local virtual machine and it'll likely not work on bare metal without adjustment.

# Usage
Build an iso using Nix and install the iso in a virtual machine.

Run `sudo -i`, `cd /iso/scripts` and then `bash install.sh`. This script will partition a btrfs setup using disko, assuming your disk is `vda` as is typical in a virtual machine, and then move files to the correct location. You will be prompted by disko to confirm partitioning and then asked for a LUKS password.

Once done, run `nixos-install --no-root-passwd --flake /etc/nixos/#Porygon`. Disclaimer: That command might not work, I'm writing this readme from memory. This is mostly for myself and I don't expect anyone else to use it anyway tbh.
