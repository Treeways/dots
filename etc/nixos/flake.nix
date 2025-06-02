{
	description = "Hyperlight configuration";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; # Change this on system update!
		# chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

		nixos-hardware.url = "github:NixOS/nixos-hardware/master";

		home-manager.url = "github:nix-community/home-manager/release-25.05"; # Change this on system update!
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { nixpkgs, /* chaotic, */ nixos-hardware, home-manager, ... }: {
		nixosConfigurations.hyperlight = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				# chaotic.nixosModules.nyx-cache
				# chaotic.nixosModules.nyx-overlay
				# chaotic.nixosModules.nyx-registry

				nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2

				home-manager.nixosModules.home-manager {
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
				}
			];
		};
	};
}
