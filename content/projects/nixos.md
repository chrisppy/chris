+++
title = "nixos"
description = "My personal NixOS configuration, managed as a Nix flake across all my machines."
template = "project.html"

[taxonomies]
tags = ["nix", "nixos", "home-manager", "niri", "sops-nix", "open-source"]

[extra]
remote_md = [{ url = "https://raw.githubusercontent.com/chrisppy/nixos/master/README.md", strip_title = true, base = "https://github.com/chrisppy/nixos/blob/master/" }]
+++

This flake is where my other projects get used day to day:
[base24-themes](/projects/base24-themes/), [birdland](/projects/birdland/),
[devfmt](/projects/devfmt/), [freecad-flake](/projects/freecad-flake/), and
[pressbox](/projects/pressbox/) are all inputs to this flake.

Source: [github.com/chrisppy/nixos](https://github.com/chrisppy/nixos)
