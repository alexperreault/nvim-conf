# nvim-conf

Ma config Neovim, construite avec [nvf](https://nvf.notashelf.dev/).

## Installation

Requiert Nix avec les flakes activés.

```sh
nix profile install github:alexperreault/nvim-conf#nvim
```

Pour l'essayer sans rien installer :

```sh
nix run github:alexperreault/nvim-conf
```

Fournit `nvim`, ainsi que les alias `vi` et `vim`. N'affecte pas `~/.config/nvim`

Mise à jour : `nix profile upgrade nvim`.

## Installation sur NixOS

Ajouter ce dépôt aux entrées du flake système :

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvim-conf.url = "github:alexperreault/nvim-conf";
    # ou en local : nvim-conf.url = "path:/chemin/vers/nvim-conf";
  };

  outputs = {nixpkgs, nvim-conf, ...}: {
    nixosConfigurations.<hôte> = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        ({pkgs, ...}: {
          environment.systemPackages = [
            nvim-conf.packages.${pkgs.stdenv.hostPlatform.system}.nvim
          ];
        })
      ];
    };
  };
}
```

```sh
sudo nixos-rebuild switch --flake .#<hôte>
```

## Utilisation

```sh
nix run .          # lancer sans installer
nix build .#nvim   # construire dans ./result
nix develop        # shell avec ce nvim dans le PATH
```
