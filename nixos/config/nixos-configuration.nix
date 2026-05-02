{ inputs, config, pkgs, ... }:

{
 	imports = [
 		"${inputs.disko}/module.nix"
 		./hardware-configuration.nix
 		./disko-configuration.nix
	];

#----- SYSTEM CONFIGURATION
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	#--- Boot, Network and Security
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};
		plymouth = {
			enable = true;
		};
		consoleLogLevel = 3;
		initrd.verbose = false;
		kernelPackages = pkgs.linuxPackages_latest;
		kernelParams = [
			"quiet"
			"udev.log_level=3"
			"systemd.show_status=auto"
		];
		loader.timeout = 0;
	};

	networking = {
		hostName = "Porygon";
		networkmanager.enable = true;
	};

	security = {
		rtkit.enable = true;
		polkit.enable = true;
	};

	#--- Nix Services
	services = {
		printing.enable = true;
		gvfs.enable = true;
		gnome.gnome-keyring.enable = true;

		pipewire = {
			enable = true;
			alsa.enable = true;
			# Suggested by the NixOS wiki, but is this necessary on a 64-bit system?
			alsa.support32Bit = true;
			pulse.enable = true;
		};

		greetd = {
			enable = true;
			settings = rec {
				default_session = {
					command = "${config.programs.niri.package}/bin/niri-session";
					user = "Raindrop";
				};
			};
		};

		flatpak = {
			enable = true;
			packages = [
				"org.gnome.Epiphany"
				"org.gnome.baobab"
				"org.gnome.Calculator"
				"org.gnome.Calendar"
				"org.gnome.Characters"
				"org.gnome.clocks"
				"org.gnome.Contacts"
				"org.gnome.Decibels"
				"org.gnome.Papers"
				"org.gnome.DejaDup"
				"org.gnome.font-viewer"
				"org.gnome.Loupe"
				"org.gnome.Maps"
				"org.gnome.meld"
				"org.gnome.TextEditor"
				"org.gnome.Showtime"
				"org.gnome.Builder"
				"org.gnome.Music"gi
				"io.github.flattool.Warehouse"
				"io.github.nokse22.Exhibit"
				"com.github.tchx84.Flatseal"
				"io.github.flattool.Ignition"
				"io.github.fabrialberio.pinapp"
				"com.github.PintaProject.Pinta"
				"org.gnome.gitlab.YaLTeR.VideoTrimmer"
				"re.sonny.Junction"
			];
		};
	};

	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-wlr
			xdg-desktop-portal-gtk
		];
	};

	#--- systemd Services
	systemd.user.services = {
		polkit-gnome-auth = {
			description = "polkit-gnome authentication agent";
			wantedBy = [ "graphical-session.target" ];
			wants = [ "graphical-session.target" ];
			after = [ "graphical-session.target" ];
			serviceConfig = {
				Type = "simple";
				ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
				Restart = "on-failure";
				RestartSec = 1;
				TimeoutStopSec = 10;
			};
		};
	};

	#--- Virtual Machine Setup
	fileSystems."/nix/flakes/Snowdrake" = {
		device = "Snowdrake";
		fsType = "virtiofs";
		options = [ "ro" "nofail" ];
	};

	services.spice-vdagentd.enable = true;
	services.qemuGuest.enable = true;

#----- SYSTEM PACKAGES
	#--- Declare packages
	environment.systemPackages = with pkgs; [
		#- Core
		ghostty xwayland-satellite bazaar

		#- CLI
		fastfetch tldr starship git

		#- GNOME Apps
		nautilus polkit_gnome

		#- Other
		steam sunshine

		#- Themes
		adwaita-icon-theme adwaita-icon-theme-legacy morewaita-icon-theme
	];

	fonts.packages = with pkgs; [
		adwaita-fonts
		nerd-fonts.adwaita-mono
	];

	programs = {
		fish.enable = true;
		niri.enable = true;
		dms-shell = {
			enable = true;
			systemd = {
				enable = true;
				restartIfChanged = true;
			};
			# To-Do: Remove these, see if they're necessary
			enableSystemMonitoring = true;
			enableVPN = true;
			enableDynamicTheming = true;
			enableAudioWavelength = true;
			enableCalendarEvents = true;
			enableClipboardPaste = true;
		};
		dsearch.enable = true;
	};

#----- USER CONFIGURATION
	time.timeZone = "America/New_York";
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	users.users.Raindrop = {
		isNormalUser = true;
		description = "Raindrop";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
		];
	};

#----- VERSIONING
	system.stateVersion = "25.11";
}