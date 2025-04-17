# Default configuration for all hosts
{ config, lib, pkgs, shared, ... }:

{
  # Default modules
  imports = [
    ../modules/home-manager.nix

    ../modules/sway
    ../modules/alacritty.nix
    ../modules/bash.nix
    ../modules/neovim
    ../modules/git.nix
  ];

  # User - Don't forget to passwd
  users.users.${shared.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  # Disable the GRUB boot loader
  boot.loader.grub.enable = false;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Networking
  networking.hostName = "${shared.hostname}";
  networking.networkmanager = {
    enable = true;
    wifi.powersave = true;
  };
  networking.firewall.enable = true;
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Brussels";

  # Fonts
  fonts.packages = with pkgs; [
    liberation_ttf
    nerd-fonts.jetbrains-mono
    openmoji-color
  ];

  # Enable SSH
  services.openssh.enable = true;

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto-upgrade
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
  };
}
