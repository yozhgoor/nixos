{ config, lib, pkgs, shared, ... }:

{
  services.hardware.openrgb.enable = true;

  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      openrgb
    ];
  };
}
