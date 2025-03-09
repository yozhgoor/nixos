{ config, lib, pkgs, ... }:

{
  imports = [
    ./sway.nix
    ./git.nix
    ./bash.nix
    ./terminal.nix
    ./neovim.nix
  ];

  # User - Don't forget to create a password with `passwd`.
  users.users.yozhgoor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  home-manager.users.yozhgoor = {
    home.username = "yozhgoor";
    home.homeDirectory = "/home/yozhgoor";

    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      firefox-wayland

      spotify

      rustup
      gcc
      cmake

      cargo-temp
      cargo-release
      cargo-rdme
    ];

    programs.home-manager.enable = true;

    home.stateVersion = "24.11";
  }
}
