{ config, lib, pkgs, ...}:

{
  home-manager.users.yozhgoor = {
    programs.bash = {
      enable = true;
      shellAliases = {
        ls = "ls --color=auto";
        grep = "grep --color=auto";
      };
      profileExtra = ''
        if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
          exec sway
        fi
      '';
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        character = {
          format = "[👽](bold #00FF00) ";
          success_symbol = "[👽](bold green) ";
          error_symbol = "[👽](bold red) ";
        };
        directory.style = "bold #00FF00";
        git_branch.style = "bold #00FF00";
        shell.style = "bold #00FF00";
        rust.style = "bold #00FF00";
        time.style = "bold #00FF00";
        package.disabled = true;
      };
    };
  };
}
