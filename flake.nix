{
  description = "Personal Neovim configuration, built with nvf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nvf,
      ...
    }:
    let
      systems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: rec {
        nvim =
          (nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [ ./config ];
          }).neovim;

        default = nvim;
      });

      apps = forAllSystems (
        pkgs:
        let
          inherit (pkgs.stdenv.hostPlatform) system;
        in
        rec {
          nvim = {
            type = "app";
            program = "${self.packages.${system}.nvim}/bin/nvim";
          };

          default = nvim;
        }
      );

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            self.packages.${pkgs.stdenv.hostPlatform.system}.nvim
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixfmt);
    };
}
