# Alacritty configuration
{ config, lib, pkgs, shared, ... }:

{
  home-manager.users.${shared.username} = {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          size = 10;
          normal = {
            family = "Jetbrains Mono Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "Jetbrains Mono Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "Jetbrains Mono Nerd Font";
            style = "Italic";
          };
        };
        colors = {
          primary = {
            background = "0x101010";
            foreground = "0xd5C4A1";
          };
          normal = {
            black = "0x282828";
            red = "0xcc241d";
            green = "0x98971a";
            yellow = "0xd79921";
            blue = "0x458588";
            magenta = "0xb16286";
            cyan = "0x689d6a";
            white = "0xa89984";
          };
          bright = {
            black = "0x928374";
            red = "0xfb4934";
            green = "0x98971a";
            yellow = "0xfabd2f";
            blue = "0x83a598";
            magenta = "0xd3869b";
            cyan = "0x8ec07c";
            white = "0xebdbb2";
          };
          cursor = {
            text = "0x282828";
            cursor = "0x00ff00";
          };
          selection = {
            text = "0xebdbb2";
            background = "0x3c3836";
          };
        };
      };
    };
  };
}
