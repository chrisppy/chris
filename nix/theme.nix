{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:

    let
      base24 = inputs.base24-themes.lib.base24;
      # Camden was renamed Birdland in base24-themes, and its themes moved
      # under lib.base24. The generated file keeps its _camden.scss name.
      theme = base24.themes.birdland;
      colors = base24.getColors theme;

      scssColors = builtins.concatStringsSep "\n" (
        map (name: "$" + name + ": #" + colors.${name} + ";") base24.colorNames
      );

      cssColors = builtins.concatStringsSep "\n" (
        map (name: "  --${name}: #" + colors.${name} + ";") base24.colorNames
      );

      generatedScss = ''
        // Generated from chrisppy/base24-themes
        // Scheme: ${theme.name}
        // Variant: ${theme.variant}
        // Do not edit manually.

        ${scssColors}

        :root {
        ${cssColors}
        }
      '';
    in
    {
      packages.generate-camden-scss = pkgs.writeShellApplication {
        name = "generate-camden-scss";

        runtimeInputs = [
          pkgs.coreutils
        ];

        text = ''
          set -euo pipefail

          output="''${1:-sass/_camden.scss}"

          mkdir -p "$(dirname "$output")"

          cat > "$output" <<'THEME_SCSS'
          ${generatedScss}
          THEME_SCSS

          echo "Generated $output"
        '';
      };
    };
}
