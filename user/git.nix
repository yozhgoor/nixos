{ config, lib, pkgs, ... }:

{
  home-manager.users.yozhgoor = {
    programs.git = {
      enable = true;
      userName = "yozhgoor";
      userEmail = "yozhgoor@outlook.com";
      extraConfig = {
        core = {
          editor = "nvim";
          excludesFiles = ".gitignore_global";
        };
        push = { autoSetupRemote = true; };
        pull = { rebase = false; };
        init = { defaultBranch = "main"; };
      };
    };

    home.file.".gitignore_global".text = ''
      # Rust
      debug/
      target/
      **/*.rs.bk
    '';
  };
}
