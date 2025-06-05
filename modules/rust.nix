# Configuration related to Rust
{ inputs, config, pkgs, shared, ... }:

{
  home-manager.users.${shared.username} ={
    home.packages = with pkgs; [
      rustup
      gcc

      cargo-temp
      cargo-release
      cargo-rdme
      cargo-outdated
      cargo-watch
    ];
  };

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      lazyLoad.settings.ft = "rust";
      inlayHints = true;
      servers.rust_analyzer = {
        enable = true;

        installCargo = false;
        installRustc = false;

        settings = {
          cargo.features = "all";
          checkOnSave = true;
          check.command = "clippy";
          imports.granularity.group = "module";
          inlayHints = {
            closingBraceHints.enable = false;
          };
        };
      };
    };
    autoCmd = [
      {
        event = "BufWritePre";
        pattern = "*.rs";
        callback = {
          __raw = ''
            function()
              vim.lsp.buf.format({ timeout_ms = 200 })
            end
          '';
        };
      }
    ];
  };
}
