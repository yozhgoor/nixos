# Shell (Bash) configuration
{ config, lib, pkgs, shared, ... }:

{
  home-manager.users.${shared.username} = {
    home.packages = with pkgs; [
      bat
      ripgrep
    ];

    programs.bash = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        bat = "bat --decorations never";
      };
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          format = "[](bold #00FF00) ";
          success_symbol = "[](bold green) ";
          error_symbol = "[](bold red) ";
        };
        package.disabled = true;
      };
    };
  };
}
