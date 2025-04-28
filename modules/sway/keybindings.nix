# Keybindings configuration for Sway
{ config, pkgs, mod, ... }:

{
  wayland.windowManager.sway.config.keybindings =
  let
    mod = "Mod4";
  in {
    # Shortcuts
    "${mod}+b" = "exec ${pkgs.firefox-wayland}/bin/firefox";
    "${mod}+t" = "exec ${pkgs.alacritty}/bin/alacritty";
    "${mod}+d" = "exec ${pkgs.wofi}/bin/wofi --show drun";
    "${mod}+Shift+q" = "kill";
    "${mod}+Shift+p" = "exec ${pkgs.swaylock}/bin/swaylock -f -c 000000";
    "${mod}+Print" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.swappy}/bin/swappy -f -";

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
}
