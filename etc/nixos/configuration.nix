{ config, pkgs, ... }:

{
	imports = [
		# <nixos-hardware/lenovo/thinkpad/x1-extreme/gen2>
		./hardware-configuration.nix
		./system.nix
		./nvidia.nix

		./packages.nix
		./firefox.nix
		# <home-manager/nixos>
	];

	system.stateVersion = "24.11"; # Did you read the comment?
}
