{
  description = "Sanctuary's NixOS System";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.sanctuary = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
	    modules = [
	      ./configuration
        inputs.home-manager.nixosModules.home-manager
	      {
          home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.yozhgoor = import ./user;
	      }
	    ];
    };
  };
}
