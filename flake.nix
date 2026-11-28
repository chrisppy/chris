{
  description = "chris.palmerlife.online";

  # No flake inputs: everything is pinned with tack in .tack/pins.toml
  # (`just update` to move pins). Using this flake doesn't need tack; the
  # resolver in .tack/default.nix reads the lock.
  outputs =
    { self, ... }@args:
    let
      pins = (import ./.tack) { overrides = args.tackOverrides or { }; };
      # What devfmt's mkFlake (flake-parts) expects: flake-style inputs and self.
      inputs =
        removeAttrs pins [
          "__functor"
          "_meta"
          "_patched"
        ]
        // {
          inherit self;
        };
    in
    inputs.devfmt.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.devfmt.lib.importTree ./nix)
      ];
    };
}
