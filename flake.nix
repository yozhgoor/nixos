{
  description = "Yozhgoor's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: let
  in {
    nixosConfigurations = {
      "sanctuary" = let
        shared = {
          hostname = "sanctuary";
          system = "x86_64-linux";
          username = "yozhgoor";
        };
      in nixpkgs.lib.nixosSystem {
        system = shared.system;
        specialArgs = { inherit shared; };
	      modules = [
	        ./configuration/sanctuary

          inputs.home-manager.nixosModules.home-manager
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd
          inputs.nixvim.nixosModules.nixvim
          inputs.nur.modules.nixos.default
	      ];
      };
      "discovery" = let
        shared = {
          hostname = "discovery";
          system = "x86-64-linux";
          username = "yozhgoor";
        };
      in nixpkgs.lib.nixosSystem {
        system = shared.system;
        specialArgs = { inherit shared; };
        modules = [
          ./configuration/discovery

          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.nixosModules.nixvim
          inputs.nur.modules.nixos.default
        ];
      };
      "nostromo" = let
        shared = {
          hostname = "nostromo";
          system = "aarch64-linux";
          username = "guest";
        };
      in nixpkgs.lib.nixosSystem {
        system = shared.system;
        specialArgs = { inherit shared; };
        modules = [
          ./configuration/nostromo

          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.nixosModules.nixvim
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
        ];
      };
    };
  };
}
