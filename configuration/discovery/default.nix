{ config, lib, pkgs, shared, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../default.nix

    ../../modules/git.nix
    ../../modules/i3.nix
    ../../modules/rust.nix
    ../../modules/markdown.nix
    ../../modules/firefox.nix
  ];

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      spotify
      telegram-desktop
      steam
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "24.11"; # NEVER change this value after the initial install.
}
