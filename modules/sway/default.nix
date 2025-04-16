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
          "eDP-1" = {
            mode = "1920x1080@60hz";
            position = "1920 0";
          };
          "DP*" = {
            mode = "1920x1080@60hz";
            position = "0 0";
          };
        };
        defaultWorkspace = "workspace number 1";
      };
      extraConfig = ''
        bindswitch --reload --locked lid:on output eDP-1 disable
        bindswitch --reload --locked lid:off output eDP-1 enable
        exec_always --no-startup-id /home/${shared.username}/.config/sway/clamshell_mode.sh
      '';
    };

    home.file.".config/sway/clamshell_mode.sh" = {
      text = ''
        #!/bin/sh

        LAPTOP_OUTPUT="eDP-1"
        LID_STATE_FILE="/proc/acpi/button/lid/LID/state"

        read -r LID_STATE < "$LID_STATE_FILE"

        case "$LID_STATE" in
            *open*)
                swaymsg output "$LAPTOP_OUTPUT" enable
                ;;
            *closed*)
                swaymsg output "$LAPTOP_OUTPUT" disable
                ;;
            *)
                echo "Could not get lid state" >&2
                exit 1
                ;;
        esac
      '';
      executable = true;
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
