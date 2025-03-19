{
  description = "Yozhgoor's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: let
    shared = {
      hostname = "sanctuary";
      system = "x86_64-linux";
      username = "yozhgoor";
    };
  in {
    nixosConfigurations.${shared.hostname} = nixpkgs.lib.nixosSystem {
      system = shared.system;
      specialArgs = { inherit shared; };
	    modules = [
	      ./configuration

        inputs.home-manager.nixosModules.home-manager
        inputs.nixvim.nixosModules.nixvim
	    ];
    };
  };
}
