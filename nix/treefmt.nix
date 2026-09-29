{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt =
    { pkgs, ... }:
    {
      projectRootFile = "flake.nix";
      settings = {
        on-unmatched = "fatal";
        global.excludes = [
          "LICENSE"
          ".git"
          ".gitattributes"
          ".gitignore"
        ];
        formatter = {
          djlint.options = [
            "--profile=tera"
          ];
          taplo.options = [
            "fmt"
            "-o"
            "align_entries=true"
            "-o"
            "reorder_keys=true"
          ];
        };
      };

      programs = {
        deno = {
          enable = true;
          includes = [
            "*.markdown"
            "*.md"
            "*.scss"
          ];
        };
        djlint = {
          enable = true;
          includes = [
            "*.html"
          ];
          lint = true;
        };
        just.enable = true;
        mdformat.enable = true;
        taplo.enable = true;

        deadnix = {
          enable = true;
          priority = 1;
        };
        statix = {
          enable = true;
          priority = 2;
        };
        nixf-diagnose = {
          enable = true;
          priority = 3;
        };
        nixfmt = {
          enable = true;
          package = inputs.nixfmt-rs.packages.${pkgs.stdenv.hostPlatform.system}.default;
          priority = 4;
        };
      };
    };
}
