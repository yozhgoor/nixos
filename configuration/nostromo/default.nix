{ config, pkgs, lib, shared, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  users = {
    mutableUsers = false;
    users.${shared.username} = {
      password = "${shared.username}";
    };
  };

  services.getty.autologinUser = "${shared.username}";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      generic-extlinux-compatible.enable = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
  ];

  system.stateVersion = "23.11";
}
