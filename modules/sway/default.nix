# Default configuration for Sway
{ inputs, config, pkgs, shared, ... }:

{
  security.polkit.enable = true;
  hardware.graphics.enable = true;

  home-manager.users.${shared.username} = {
    imports = [
      ./keybindings.nix
      ./waybar.nix
      ./wofi.nix
    ];
      
    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        modifier = "Mod4";
        startup = [
          { command = "swaybg -m fill -i ${./bg.png}"; } 
        ];
        fonts = {
          names = [ "Jetbrains Mono" ];
          size = 10.0;
        };
        window = {
          border = 0;
          titlebar = false;
        };
        bars = [{
          command = "${pkgs.waybar}/bin/waybar";
          fonts = {
            names = [ "Jetbrains Mono" ];
            size = 9.0;
          };
        }];
        output = {
          "eDP1" = {
            mode = "1920x1080@60hz";
          };
        };
        defaultWorkspace = "workspace number 1";
      };
    };

    home.packages = with pkgs; [
      swaybg
      brightnessctl
      wl-clipboard
    ];

    programs.bash = {
      profileExtra = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
          exec sway
        fi
      '';
    };
  };
}
