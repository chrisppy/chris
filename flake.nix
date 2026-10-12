{
  description = "A structured Base16/Base24 YAML theme flake";

  inputs = {
    base24-themes = {
      url = "github:chrisppy/base24-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    devfmt = {
      url = "github:chrisppy/devfmt";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.devfmt.inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.devfmt.inputs.systems;
      imports = [
        (inputs.devfmt.inputs.import-tree ./nix)
        inputs.devfmt.flakeModules.default
      ];
    };
}
