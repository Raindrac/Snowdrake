{
	description = "NixOS Core Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		disko.url = "github:nix-community/disko/master";
		nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
		home-manager.url = "github:nix-community/home-manager/release-25.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, nix-flatpak, home-manager, ... } @ inputs:
	{
		nixosConfigurations = {
			Porygon = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs;};
				modules = [
					nix-flatpak.nixosModules.nix-flatpak
					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.extraSpecialArgs = { inherit inputs; };
						home-manager.users.Raindrop = ./home/home-configuration.nix;
					}
					./system/nixos-configuration.nix
				];
			};	
		};
	};
}