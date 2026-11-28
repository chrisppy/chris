{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      # nixpkgs' Zola, for CI (`nix eval .#zola.version`, `nix shell .#zola`),
      # now that there is no nixpkgs flake input to reach it with --inputs-from.
      packages.zola = pkgs.zola;

      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.just
          pkgs.zola
          inputs.tack.packages.${system}.tack
        ];

        shellHook = ''
          echo
          echo "Chris Palmer — personal website"
          echo
          echo "Zola: $(zola --version)"
          echo "Just: $(just --version)"
          echo
          echo "Commands:"
          just --list
          echo
        '';
      };
    };
}
