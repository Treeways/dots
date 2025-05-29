{ config, pkgs, ... }:

{
	home.username = "treeways";
	home.homeDirectory = "/home/treeways";

	# To update the value, first check the Home Manager release notes.
	home.stateVersion = "24.11";

	nixpkgs.config.allowUnfree = true;
	home.packages = with pkgs; [
		# Global aliases between shells :)
		(pkgs.writeShellScriptBin "q" "kill -9 $PPID")
		(pkgs.writeShellScriptBin "mkcd" "mkdir \"$1\"; cd \"$1\";")
		(pkgs.writeShellScriptBin "hrc" "vim ~/.config/home-manager/home.nix")
		(pkgs.writeShellScriptBin "hsw" "home-manager switch")
		(pkgs.writeShellScriptBin "nrc" "sudo vim /etc/nixos")
		(pkgs.writeShellScriptBin "nsw" "sudo nixos-rebuild switch")
		(pkgs.writeShellScriptBin "ncl" "sudo nix-collect-garbage --delete-old")
		(pkgs.writeShellScriptBin "nix-index-download-db" ''
			  filename="index-$(uname -m | sed 's/^arm64$/aarch64/')-$(uname | tr A-Z a-z)"
			  mkdir -p ~/.cache/nix-index && cd ~/.cache/nix-index
			  wget -q -N https://github.com/nix-community/nix-index-database/releases/latest/download/$filename
			  ln -f $filename files
		'')

		(pkgs.writeShellScriptBin "init-treeways" ''
			git config user.name "Treeways"
			git config user.email "56928485+Treeways@users.noreply.github.com"
		'')

		# Dots backup - add configs as needed
		(pkgs.writeShellScriptBin "backup-dots" ''
			DOTS_BACKUP_DIR="$HOME/Dev/dots"
			DOTS_HOME_DIR="$DOTS_BACKUP_DIR/home/treeways/"
			cp /etc/nixos/* "$DOTS_BACKUP_DIR/etc/nixos" -r
			cp "$HOME/.bashrc" "$DOTS_HOME_DIR/"
			cp -r "$HOME/.config/home-manager" "$DOTS_HOME_DIR/.config/"
			cp -r "$HOME/.config/alacritty" "$DOTS_HOME_DIR/.config/"
			cp -r "$HOME/.config/niri" "$DOTS_HOME_DIR/.config/"
			cp -r "$HOME/.config/waybar" "$DOTS_HOME_DIR/.config/"
			cp -r "$HOME/.config/wpaperd" "$DOTS_HOME_DIR/.config/"

			cd $DOTS_BACKUP_DIR
			eval `ssh-agent -s` && ssh-add "$HOME/.ssh/id_rsa_treeway7"
			git fetch && git add -A && git commit -m "Backup dots" && git push
			ssh-agent -k
		'')
	];

	home.sessionVariables = {
		EDITOR = "vim";
	};

	# Let Home Manager install and manage itself.
	# programs.home-manager.enable = true;

	programs.zsh = {
		enable = true;
		oh-my-zsh.enable = true;

		autosuggestion.enable = true;
		autocd = true;
		history.save = 1000000;
		history.size = 1000000;
		syntaxHighlighting = {
			enable = true;
			highlighters = [
				"brackets"
				# "cursor"
				"root"
				"line"
			];
		};
	};
	programs.oh-my-posh = {
		enable = true;
		enableZshIntegration = true;
		# useTheme="honukai";
		useTheme="nordtron";
	};
	programs.carapace = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.mcfly = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.lsd = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};

	# After installation, this should be set separately in Niri's config.
	home.pointerCursor = {
		name = "macOS";
		package = pkgs.apple-cursor;
		size = 32;
	};
	
	gtk = {
		enable = true;
		font.name = "Inter";
	    	iconTheme = {
			name = "WhiteSur-dark";
			package = pkgs.whitesur-icon-theme;
		};
		theme = {
			name = "WhiteSur-Dark-solid";
			package = pkgs.whitesur-gtk-theme;
		};
 	};

	qt = {
		enable = true;
		platformTheme.name = "qtct";
		style.name = "kvantum";
	};

	xdg.configFile = {
		"Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
		"Kvantum/kvantum.kvconfig".text = "[General]\ntheme=ArcDark";
	};
}

