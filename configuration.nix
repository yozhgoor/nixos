{ inputs, config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix # Hardware configuration
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "sanctuary"; # Define your hostname.
  networking.networkmanager.enable = true;  # Enable NetworkManager.
  networking.firewall.enable = true;
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Brussels";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    font-awesome

    nerd-fonts.jetbrains-mono
  ];

  # User - Don't forget to create a password with `passwd`.
  users.users.yozhgoor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  # Enable Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Required by Sway
  security.polkit.enable = true;
  hardware.graphics.enable = true;

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Enable SSH
  services.openssh = {
    enable = true;
  };

  # Enable sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Allow Unfree software
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto-upgrade
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "24.11"; # NEVER change this value after the initial install.
}
