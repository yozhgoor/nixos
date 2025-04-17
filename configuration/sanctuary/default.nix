# Default configuration specific to `sanctuary`
{ inputs, config, pkgs, shared, ... }:

{
  # Host's modules
  imports = [
    ./hardware-configuration.nix # Host's hardware configuration
    ../default.nix # Default NixOS configuration

    ../../modules/rust.nix
    ../../modules/markdown.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  networking.networkmanager.wifi.powersave = true;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth nfc wifi wwan";
      DEVICES_TO_DISABLE_ON_LAN_CONNECT = "wifi wwan";
      DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = "wifi wwan";

      USB_AUTOSUSPEND = 0;
    };
  };

  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      firefox-wayland
      spotify
      telegram-desktop
    ];
  };

  # Allow Unfree software
  nixpkgs.config.allowUnfree = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  system.stateVersion = "24.11"; # NEVER change this value after the initial install.
}
