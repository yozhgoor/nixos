# Default configuration specific to `nostromo`
{ config, pkgs, lib, ...}:

{
  # Host's modules
  imports = [
    ./hardware-configuration.nix # Host's hardware configuration
    ../default.nix # Default NixOS configuration
  ];
  
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

  # Autologin on the `guest` user
  services.getty.autologinUser = "guest";

  # System packages
  environment.systemPackages = with pkgs; [
    raspberrypi-eeprom
  ];

  system.stateVersion = "23.11";
}
