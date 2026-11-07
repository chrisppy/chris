{ inputs, ... }:

{
  perSystem =
    { pkgs, ... }:

    let
      base24 = inputs.base24-themes.lib.base24;
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
      packages.generate-theme-scss = pkgs.writeShellApplication {
        name = "generate-theme-scss";

        runtimeInputs = [
          pkgs.coreutils
        ];

        text = ''
          set -euo pipefail

          output="''${1:-sass/_theme.scss}"

          mkdir -p "$(dirname "$output")"

          # generatedScss ends in a newline, so the delimiter follows it
          # directly: no trailing blank line for the formatter to remove.
          cat > "$output" <<'THEME_SCSS'
          ${generatedScss}THEME_SCSS

          echo "Generated $output"
        '';
      };
    };
}
