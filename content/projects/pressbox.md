+++
title = "pressbox"
description = "A self-hosted RSS/Atom/JSON Feed aggregator, configured in NixOS, with terminal and iOS clients."
template = "project.html"

[taxonomies]
tags = ["rust", "nix", "nixos", "rss", "atom", "self-hosted", "open-source"]

[extra]
remote_md = [{ url = "https://raw.githubusercontent.com/chrisppy/pressbox/master/README.md", strip_title = true, stop_at = "## Project layout", links = { "https://github.com/chrisppy/birdland" = "/projects/birdland/", "https://github.com/chrisppy/pressbox-ios" = "/projects/pressbox-ios/", "./docs/server.md" = "#server-nixos", "./docs/pairing.md" = "#pairing-devices", "./docs/pressboxctl.md" = "#pressboxctl", "./docs/clients.md" = "#clients-home-manager", "./docs/api.md" = "#api" }, base = "https://github.com/chrisppy/pressbox/blob/master/" }, { url = "https://raw.githubusercontent.com/chrisppy/pressbox/master/docs/server.md", links = { "./pairing.md" = "#pairing-devices" } }, { url = "https://raw.githubusercontent.com/chrisppy/pressbox/master/docs/pairing.md" }, { url = "https://raw.githubusercontent.com/chrisppy/pressbox/master/docs/pressboxctl.md" }, { url = "https://raw.githubusercontent.com/chrisppy/pressbox/master/docs/clients.md", links = { "https://github.com/chrisppy/birdland" = "/projects/birdland/", "https://github.com/chrisppy/birdland/blob/master/docs/usage.md#configuration-options" = "/projects/birdland/#configuration-options" } }, { url = "https://raw.githubusercontent.com/chrisppy/pressbox/master/docs/api.md" }]
+++

Source: [github.com/chrisppy/pressbox](https://github.com/chrisppy/pressbox)
