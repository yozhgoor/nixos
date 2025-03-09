# NixOS configuration

This repository keep track of my personal [NixOS][nixos] configuration.

This setup uses Nix [Flakes][flakes] and [Home Manager][home-manager]. The main configuration can be
found at [`configuration.nix`](configuration.nix) and the user-specific settings in
[`home.nix`](home.nix)

## Usage

Rebuild the system:
```
sudo nixos-rebuild switch --flake <path_to_repo>
```

## Upgrade

You can upgrade NixOS to the latest version by running:
```
nixos-rebuild switch --upgrade --flake <path_to_repo>
```

Note that auto-upgrade is enabled in `configuration.nix`.

## Clean up

To remove old, unreferenced packages:
```
nix-collect-garbage
```

The following command deletes old roots, removing the ability to roll back to them:
```
nix-collect-garbage -d
sudo nix-collect-garbage -d
```

To delete all historical versions you can use
```
sudo nix profile wipe-history
```

## Optimize

You can manually optimize the store using:
```
nix-store --optimise
```

[nixos]: https://nixos.org
[home-manager]: https://github.com/nix-community/home-manager
[flakes]: https://nixos.wiki/wiki/flakes
