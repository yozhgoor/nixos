{ inputs, config, pkgs, shared, ... }:

{
  # User - Don't forget to create a password with `passwd`.
  users.users.${shared.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${shared.username} = {
    imports = [
      ./bash.nix
      ./alacritty.nix
      ./git.nix
    ];

    home.username = "${shared.username}";
    home.homeDirectory = "/home/${shared.username}";

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
  };
}
