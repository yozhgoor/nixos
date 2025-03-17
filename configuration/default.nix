{ inputs, config, pkgs, shared, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./neovim.nix
    
    ./sway
    ./user
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "${shared.hostname}";
  networking.networkmanager.enable = true;
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
    liberation_ttf
    nerd-fonts.jetbrains-mono
  ];

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
