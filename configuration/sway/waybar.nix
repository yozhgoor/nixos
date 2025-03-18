{ config, pkgs, ... }:

{
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
}
