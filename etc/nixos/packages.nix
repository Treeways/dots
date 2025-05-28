{ config, pkgs, ... }:

{
	# Allow unfree and unstable packages
	nixpkgs.config = {
		allowUnfree = true;
		packageOverrides = pkgs: {
			unstable = import <nixos-unstable> {
				config = config.nixpkgs.config;
			};
		};
	};

	environment.systemPackages = with pkgs; [
		# System
		comma
		mako
		alacritty
		fuzzel
		xfce.thunar
		xfce.thunar-vcs-plugin
		xfce.thunar-archive-plugin
		xfce.thunar-media-tags-plugin
		# spacedrive
		sayonara
		protonvpn-gui
		qdirstat
		brightnessctl
		waybar
		wpaperd
		home-manager
		git
		nixfmt-classic

		# Apps
		prismlauncher
		gftp
		vscode-fhs
		legcord
		cinny-desktop
		marktext
		vlc

		# Optional
		nwg-look
		libsForQt5.qtstyleplugin-kvantum
	];

	fonts.packages = with pkgs; [
		nerd-fonts._0xproto
		inter
		unstable.aporetic
	];

	# Don't remove Vim or Zsh unless you know what you're doing.
	programs.vim = {
		enable = true;
		defaultEditor = true;
	};
	programs.zsh.enable = true; 
}
