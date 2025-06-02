{ config, pkgs, ... }:

{
	services.flatpak.enable = true;

	# Allow unfree and unstable packages
	# nixpkgs.config = {
	# 	allowUnfree = true;
	# 	packageOverrides = pkgs: {
	# 		unstable = import <nixos-unstable> {
	# 			config = config.nixpkgs.config;
	# 		};
	# 	};
	# };
	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		# System utils
		brightnessctl
		fuzzel
		findex
		waybar
		wpaperd
		home-manager
		xwayland-satellite

		# CLI
		alacritty
		starship
		git
		lazygit 
		unzip
		comma
		ripgrep

		# System apps
		xfce.thunar
		# sayonara # Can't load my library
		amberol
		rhythmbox # Sayonara has a better UX
		xarchiver
		font-manager
		qdirstat
		thunderbird

		# Apps
		# unstable.protonvpn-gui
		protonvpn-gui
		prismlauncher
		temurin-bin-17 # for Minecraft
		filezilla
		# gftp
		vscode-fhs
		legcord
		cinny-desktop
		marktext # No .desktop file for some reason
		vlc

		# Ricing
		# nwg-look
		# libsForQt5.qtstyleplugin-kvantum
	];

	fonts.packages = with pkgs; [
		nerd-fonts._0xproto
		inter
		aporetic
	];

	# Don't remove Vim or Zsh unless you know what you're doing.
	programs.vim = {
		enable = true;
		defaultEditor = true;
	};
	programs.zsh.enable = true; 

	programs.thunar = {
		enable = true;
		plugins = with pkgs.xfce; [
			thunar-volman
			thunar-vcs-plugin
			thunar-archive-plugin # Doesn't show up for some reason
			thunar-media-tags-plugin
		];
	};
}
