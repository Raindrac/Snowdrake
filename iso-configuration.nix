{ config, pkgs, lib, ... }:

{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	services.qemuGuest.enable = true;

	isoImage.contents = [
		{
			source = ./nixos;
			target = "nixos";
		}
		{
			source = ./scripts;
			target = "scripts";
		}
	];

	system.stateVersion = "25.11";
}