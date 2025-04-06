# Home-manager configuration
{ inputs, config, pkgs, shared, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${shared.username} = {
    home.username = "${shared.username}";
    home.homeDirectory = "/home/${shared.username}";

    programs.home-manager.enable = true;

    home.stateVersion = "24.11";
  };
}
