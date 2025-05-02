{ config, lib, pkgs, shared, ... }:

{
  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;
    displayManager.startx.enable = true;
    windowManager.i3.enable = true;
  };

  home-manager.users.${shared.username} = {
    home.file.".xinitrc".text = ''
      exec i3
    '';

    programs.bash = {
      profileExtra = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
          startx
        fi
      '';
    };
  };
}
