{ inputs, config, pkgs, shared, ... }:

{
  security.polkit.enable = true;
  hardware.graphics.enable = true;

  home-manager.users.${shared.username} = 
  let
    mod = "Mod4";
  in {
    wayland.windowManager.sway = {
      enable = true;
      config = rec {
        modifier = "${mod}";
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
        keybindings = {
          # Shortcuts
          "${mod}+b" = "exec ${pkgs.firefox-wayland}/bin/firefox";
          "${mod}+t" = "exec ${pkgs.alacritty}/bin/alacritty";
          "${mod}+d" = "exec ${pkgs.wofi}/bin/wofi --show drun";
          "${mod}+Shift+q" = "kill";

          # Move the focus around
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # Move the focused window around
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # Switch to workspace
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          # Move focused container to workspace
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          # Splits
          "${mod}+h" = "splith";
          "${mod}+v" = "splitv";

          # Full-screen
          "${mod}+f" = "fullscreen";

          # Function keys
          "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
          "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          "XF86AudioRaiseVolume" = "exec 'wpctl set-volume @DEFAULT_SINK@ 5%+'";
          "XF86AudioLowerVolume" = "exec 'wpctl set-volume @DEFAULT_SINK@ 5%-'";
          "XF86AudioMute" = "exec 'wpctl set-mute @DEFAULT_SINK@ toggle'";
          "XF86AudioMicMute" = "exec 'wpctl set-mute @DEFAULT_SOURCE@ toggle'";
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
            format-muted = "";
            format-icons = [ "" "" "" ];
            on-scroll-up = "";
            on-scroll-down = "";
            tooltip = false;
          };
          "cpu" = {
            interval = 10;
            format = "{}% ";
            max-length = 10;
            tooltip = false;
          };
          "memory" = {
            interval = 10;
            format = "{}% ";
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
            format-ethernet = "Wired ";
            format-linked = "{ifname} (No IP) ";
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
          format-charging = "{capacity}% 󱐋";
          format-plugged = "{capacity}% ";
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
        font-family: JetBrainsMono Nerd Font;
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

  };
}
