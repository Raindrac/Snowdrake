{ config, lib, pkgs, ... }:

with lib.hm.gvariant;
{
	home.username = "Raindrop";
	home.homeDirectory = "/home/Raindrop";
	home.stateVersion = "25.11";


	xdg.configFile."niri/config.kdl".source = ./niri/config.kdl;

#----- GNOME DCONF CONFIGURATION
	dconf.settings = {
		"org/gnome/nautilus/preferences" = {
			click-policy = "single";
			show-create-link = true;
			show-delete-permanently = true;
		};
	};
}