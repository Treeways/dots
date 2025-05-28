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
		ripgrep
		# mako
		alacritty
		fuzzel
		xfce.thunar
		# spacedrive
		# sayonara
		rhythmbox
		protonvpn-gui
		qdirstat
		brightnessctl
		waybar
		wpaperd
		home-manager
		git
		lazygit

		# Apps
		prismlauncher
		gftp
		vscode-fhs
		legcord
		cinny-desktop
		marktext
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
			thunar-vcs-plugin
			thunar-archive-plugin
			thunar-media-tags-plugin
		];
	};
}
