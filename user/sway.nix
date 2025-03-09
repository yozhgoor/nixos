{ config, lib, pkgs, ...}:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      startup = [
        {command = "swaybg -m fill -i ${./bg.png}";}
      ];
      terminal = "alacritty";
      menu = "wofi --show drun";
      fonts = {
        names = ["Jetbrains Mono"];
	      size = 10.0;
      };
      window = {
        border = 0;
        titlebar = false;
      };
      bars = [{
        command = "${pkgs.waybar}/bin/waybar";
      }];
      output = {
        "eDP1" = {
          mode = "1920x1080@60Hz";
        };
      };
      defaultWorkspace = "workspace number 1";
      keybindings =
      let
        modifier = config.wayland.windowManager.sway.config.modifier;
        terminal = config.wayland.windowManager.sway.config.terminal;
      in lib.mkOptionDefault {
        "${modifier}+b" = "exec ${pkgs.firefox-wayland}/bin/firefox";
        "${modifier}+h" = "splith";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_SINK@ 5%+'";
        "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_SINK@ 5%-'";
        "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_SINK@ toggle'";
        "XF86AudioMicMute" = "exec 'wpctl set-mut @DEFAULT_SOURCE@ toggle";
      };
    };
  };

  home.packages = with pkgs; [
    swaybg
    brightnessctl
    wl-clipboard
  ];

  programs.waybar = {
    enable = true;
    settings = [
      {
        height = 24;
        spacing = 5;
        modules-left = [ "sway/workspaces" ];
        modules-right = [
          "bluetooth"
          "backlight"
          "wireplumber"
          "cpu"
          "memory"
          "disk"
          "network"
          "clock"
          "battery"
          "tray"
        ];
        "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          format-connected = " {device_alias} connected";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
        };
        "backlight" = {
          format = "{percent}% ";
          on-scroll-up = "";
          on-scroll-down = "";
          tooltip = false;
        };
        "wireplumber" = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = [ "" "" "" ];
          on-scroll-up = "";
          on-scroll-down = "";
          tooltip = false;
        };
        "cpu" = {
          interval = 10;
          format = "{}% ";
          max-length = 10;
          tooltip = false;
        };
        "memory" = {
          interval = 10;
          format = "{}% ";
          max-length = 10;
          tooltip = false;
        };
        "disk" = {
          interval = 30;
          format = "{percentage_used}% ";
          path = "/";
          unit = "GB";
          tooltip = false;
        };
        "network" = {
          format-wifi = "{essid} ";
          format-ethernet = "Wired ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ";
          tooltip = false;
        };
        "clock" = {
          format = "{:%H:%M %d/%m/%y}";
          tooltip = false;
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-icons = [ "" "" "" "" "" ];
        };
        tray = {
          icon-size = 21;
          spacing = 5;
        };
      }
    ];
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: JetBrainsMono Nerd Font, font-awesome;
        font-size: 10px;
        min-height: 0;
        background-color: #101010;
        color: #00ff00;
      }

      #workspaces.button {
        padding: 0 5px;
        background: transparent;
        color: #a89984;
      }

      #workspace.button.focused {
        background: transparent;
        color: #00ff00;
      }

      #battery.charging {
        color: #282828;
        background-color: #00ff00;
      }

      #bluetooth, #backlight, #wireplumber, #temperature, #cpu, #memory, #disk, #network, #clock, #tray {
        margin-left: 5px;
        margin-right: 5px;
        padding: 0;
      }

      #battery {
        margin-left: 5px;
        margin-right: 10px;
        padding: 0;
      }
    '';
  };

  programs.wofi = {
    enable = true;
    style = ''
      window, #outer-box, #input, #scroll, #inner-box, #entry, #text {
        background-color: #101010;
        color: #00ff00;
      }

      #entry.selected {
        background-color: #181818;
        border: none;
      }
    '';
  };
}
