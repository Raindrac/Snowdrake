{
	description = "NixOS Core Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		disko.url = "github:nix-community/disko/master";
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
	};

	outputs = { self, nixpkgs, nix-flatpak, ... } @ inputs:
	{
		nixosConfigurations = {
			Porygon = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [
					nix-flatpak.nixosModules.nix-flatpak
					./config/nixos-configuration.nix
				];
			};	
		};
	};
}
