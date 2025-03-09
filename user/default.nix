{ config, lib, pkgs, ... }:

{
  imports = [
    ./sway.nix # Sway configuration
    ./neovim/default.nix # Neovim configuration
    ./neovim/plugin.nix # Neovim plugin configuration
    ./bash.nix # Shell configuration
    ./terminal.nix # Terminal configuration
    ./git.nix # Git configuration
  ];

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
