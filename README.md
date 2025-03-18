# NixOS configuration

This repository keep track of my personal [NixOS][nixos] configuration.

This setup uses Nix [Flakes][flakes] and [Home Manager][home-manager].

The main configuration can be found in the [`configuration`][configuration] directory.
The user-specific configuration is in the [`configuration/user`][user] directory.
The [sway][sway] configuration is in the [`configuration/sway`][sway-config] directory.
The [neovim][neovim] configuration is in the [`configuration/neovim`][neovim-config] directory.
The [`devShell`][devshell] configuration is in the [`configuration/shell.nix`][shell] file

## Usage

Rebuild the system from the local repository:
```
sudo nixos-rebuild switch --flake <path_to_repo>
```

Note that `<path_to_repo>` can be the path to the local repository but also the remote repository:
```
sudo nixos-rebuild switch --flake github:owner/repo
```

### Development

The development shell can be accessed using `nix develop`.

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
[configuration]: https://github.com/yozhgoor/nixos/blob/main/configuration
[user]: https://github.com/yozhgoor/nixos/blob/main/configuration/user
[sway]: https://swaywm.org
[sway-config]: https://github.com/yozhgoor/nixos/blob/main/configuration/sway
[neovim]: https://neovim.io
[neovim-config]: https://github.com/yozhgoor/nixos/blob/main/configuration/neovim
[devshell]: https://nixos.wiki/wiki/Development_environment_with_nix-shell#nix_develop
[shell]: https://github.com/yozhgoor/nixos/blob/main/configuration/shell.nix
