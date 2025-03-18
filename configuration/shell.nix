{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    rustc
    cargo
    
    rustfmt
    clippy

    gcc
  ];

  packages = with pkgs; [
    cargo-temp
    cargo-release
    cargo-rdme
  ];
}
