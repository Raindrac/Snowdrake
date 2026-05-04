{ config, lib, pkgs, ... }:

with lib.hm.gvariant;
{
	home.username = "Raindrop";
	home.homeDirectory = "/home/Raindrop";
	home.stateVersion = "25.11";

#----- GNOME DCONF CONFIGURATION
	dconf.settings = {
		"org/gnome/nautilus/preferences" = {
			click-policy = "single";
			show-create-link = true;
			show-delete-permanently = true;
		};
	};
}