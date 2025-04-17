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

  # Autologin on the `guest` user
  services.getty.autologinUser = "${shared.username}";

  # Use the UBoot boot loader
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
    loader = {
      generic-extlinux-compatible.enable = true;
    };
  };

  # Enable firmware with a license allowing redistribution
  hardware.enableRedistributableFirmware = true;

  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyS0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyS0 -P bcm -S 3000000";
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
  ];

  system.stateVersion = "23.11";
}
