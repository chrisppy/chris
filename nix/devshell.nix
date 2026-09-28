_: {
  perSystem =
    { pkgs, ... }:
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.just
          pkgs.zola
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
