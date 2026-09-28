{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:
    {
      packages.generate-camden-scss = pkgs.writeShellApplication {
        name = "generate-camden-scss";

        runtimeInputs = [
          pkgs.yq-go
          pkgs.coreutils
        ];

        text = ''
          set -euo pipefail

          output="''${1:-sass/_camden.scss}"
          theme="${inputs.base24-themes}/themes/camden.yaml"

          mkdir -p "$(dirname "$output")"

          {
            echo "// Generated from chrisppy/base24-themes"
            echo "// Scheme: camden"
            echo "// Variant: dark"
            echo "// Do not edit manually."
            echo

            yq -r '
              to_entries
              | .[]
              | select(.key | test("^base(0[0-9A-Fa-f]|1[0-7])$"))
              | "$" + .key + ": #" + .value + ";"
            ' "$theme"

            echo
            echo ":root {"

            yq -r '
              to_entries
              | .[]
              | select(.key | test("^base(0[0-9A-Fa-f]|1[0-7])$"))
              | "  --\(.key): #" + .value + ";"
            ' "$theme"

            echo "}"
          } > "$output"

          echo "Generated $output"
        '';
      };
    };
}
