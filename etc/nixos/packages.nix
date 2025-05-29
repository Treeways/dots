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
		# System utils
		brightnessctl
		fuzzel
		waybar
		wpaperd
		home-manager
		xwayland-satellite

		# CLI
		comma
		ripgrep
		alacritty
		git
		lazygit 
		starship

		# System apps
		xfce.thunar
		# spacedrive # Bug with onboarding
		# sayonara # Can't load my library
		rhythmbox # Sayonara has a better UX
		font-manager
		qdirstat

		# Apps
		unstable.protonvpn-gui
		prismlauncher
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
		unstable.aporetic
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
