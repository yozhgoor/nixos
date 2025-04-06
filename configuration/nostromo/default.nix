# Default configuration specific to `nostromo`
{ config, pkgs, lib, shared, ... }:

{
  # Host's modules
  imports = [
    ./hardware-configuration.nix # Host's hardware configuration
    ../default.nix # Default NixOS configuration
  ];

  users = {
    mutableUsers = false;
    users.${shared.username} = {
      password = "${shared.username}";
    };
  };
  
  # Use the UBoot boot loader
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
    loader = {
      generic-extlinux-compatible.enable = true;
    };
  };

  # Bluetooth
  hardware.raspberry-pi."4".bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyAMA0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      execStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
    };
  };

  # Enable firmware with a license allowing redistribution
  hardware.enableRedistributableFirmware = true;

  # Autologin on the `guest` user
  services.getty.autologinUser = "guest";

  # System packages
  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
  ];

  system.stateVersion = "23.11";
}
