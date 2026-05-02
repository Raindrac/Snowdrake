{
	description = "NixOS ISO construction";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
		disko.url = "github:nix-community/disko";
		disko.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, disko, ... }: {
		nixosConfigurations = {
			iso = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					({ pkgs, modulesPath, ... }: {
						imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
					})
					disko.nixosModules.disko
					./iso-configuration.nix
				];
			};
		};
	};
}