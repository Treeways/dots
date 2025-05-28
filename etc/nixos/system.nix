{ config, pkgs, ... }:

{
	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "hyperlight";
	networking.networkmanager.enable = true;

	time.timeZone = "America/Chicago";
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

	# SDDM
	services.displayManager.sddm = {
		enable = true;
		wayland.enable = true;
		theme = "where_is_my_sddm_theme";
	};

	environment.sessionVariables = {
		# Scale Electron apps in Wayland
		NIXOS_OZONE_WL = "1";
	};

	# Niri
	programs.niri.enable = true;

	security.polkit.enable = true;
	services.printing.enable = true;

	# XDG portals and MIME defaults
	xdg = {
		portal = {
			wlr.enable = true;
			enable = true;
			config.common.default = "gtk";
		};
		mime = {
			enable = true;
			defaultApplications = {
				"image/png" = "firefox.desktop";
				"inode/directory" = "thunar.desktop";
			};
		};
	};

	# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	services.gvfs.enable = true; # Mount, trash, and other functionalities
	services.tumbler.enable = true; # Thumbnail support for images

	users.defaultUserShell = pkgs.zsh;
	users.users.treeways = {
		isNormalUser = true;
		description = "Treeways";
		extraGroups = [ "networkmanager" "wheel" ];

		useDefaultShell = true;
	};
}
