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
}
