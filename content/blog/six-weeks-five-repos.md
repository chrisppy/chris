+++
title = "Six Weeks, Five New Repos"
date = 2026-11-07
description = "What I've built since my first post: a formatting flake, a FreeCAD flake, a Base24 theme library, a Quickshell desktop, and a self-hosted feed reader."

[taxonomies]
tags = ["nix", "nixos", "open-source", "quickshell", "rust", "swift", "website"]
+++

In my first post at the end of September, I said I'd write about whatever I'm
working on. Since then that has added up to five new public repos, a rework of a
sixth, and nearly 170 commits. Here's what they are and how they fit together.

## devfmt: one formatting setup for everything

The first thing I built was the boring part. Every repo I start needs a
formatter, a lint pass, and a CI check, and I was tired of copying the same
treefmt setup around and letting each copy drift.

[devfmt](/projects/devfmt/) is a flake-parts module built on treefmt-nix. A
flake that builds with `devfmt.lib.mkFlake` gets `nix fmt` for the whole tree
and a treefmt check in `nix flake check`. It has one strict rule: every file in
the repo is formatted by something or explicitly excluded.

Most of it came together in one day on October 12. Since then it has grown as
the other projects needed it. QML support came in when Birdland started,
swift-format came in for the iOS app, and REUSE license texts are now skipped.
Every other repo in this post uses it.

## freecad-flake: FreeCAD, declared

[freecad-flake](/projects/freecad-flake/) wraps FreeCAD in a NixOS and Home
Manager module. Workbench plugins in `plugins/*.nix` are discovered
automatically and each one gets its own on/off option. You can also inject your
own `user.cfg` and `system.cfg` through the launcher wrapper. The idea is that
my CAD setup gets rebuilt the same way the rest of my system does, instead of
living in a preferences dialog.

## base24-themes: one palette, many formats

[base24-themes](/projects/base24-themes/) started life as a YAML color scheme
and is now a small Nix library. Themes are plain Nix files. They're validated
for missing or malformed colors, and converters turn them into YAML, JSON, SCSS,
QML, and SVG previews. A single module for NixOS and Home Manager exposes the
selected theme as `config.lib.base24`.

Along the way the dark theme I'd been calling Camden was renamed **Birdland**
and retuned to the Orioles' colors. The same library also generates the SCSS for
this site's colors.

## Birdland: a desktop shell

[Birdland](/projects/birdland/) is the biggest of the bunch, with 45 commits
since its first one on October 19. It's a desktop shell suite for the Niri
compositor, written in QML on top of Quickshell and configured entirely through
Home Manager. It's themed by base24-themes, so changing the palette changes the
whole desktop.

It's split into separate apps, named the way you'd expect from an Orioles fan:

- **bullpen**: a status bar on every monitor, with workspaces, the focused
  window, media, tray, and indicators for CPU, memory, GPU, network, audio,
  battery, and weather
- **dugout**: an application launcher on the focused monitor
- **lineup**: a dock of favorite and running apps
- **outfield**: wallpapers, including rotating folders and per-monitor choices
- **announcer**: notification pop-ups
- **jumbotron**: a pop-up when volume, mic mute, or brightness changes
- **tarp**: a lock screen that also turns the monitors off when idle
- **gate**: a greetd login screen, set up through the NixOS module

Dugout and Lineup launch apps through Niri, so each app gets its own systemd
scope. Restarting the shell, which Home Manager does whenever its config
changes, doesn't take your open windows down with it.

## pressbox: a feed reader with no website

The newest project, published today, is [pressbox](/projects/pressbox/). It's a
self-hosted RSS, Atom, and JSON Feed aggregator. You declare the feeds and the
people who use them in your NixOS configuration, and a small Rust server polls
them into SQLite with a search index. Clients share read and starred state
through its HTTP API.

There's no web interface and no shared secret. Each client pairs with a short
code that you approve on the server with `pressboxctl` or from a device that's
already paired. The clients so far are:

- a terminal reader built with ratatui
- a feeds module in Birdland's bar showing the unread count
- [pressbox-ios](/projects/pressbox-ios/), a SwiftUI app with offline reading,
  search, optional Face ID, and an unread badge on the icon

Both pressbox repos are at 0.1.0 and very much in their early days.

## Keeping it all running

A few things run through all of these:

- **Automated flake updates.** Every repo got an `update-flake-lock` workflow in
  mid-October. Most of the commit count since then is those bots keeping inputs
  current, which is exactly the point.
- **A justfile everywhere**, so `just fmt`, `just build`, and friends work the
  same way in every repo.
- **Docs split into pages.** Each README now stays short and links to a `docs/`
  folder for usage, options, and per-component details.

## And this site

The day after the first post I filled out the home, About, and Skills pages. On
October 1 I added a [License](/license/) page: the code behind the site is MIT
and the writing is CC BY 4.0.

More recently the site picked up a [Projects](/projects/) section with a page
for each of these. Those pages pull their content straight from each repo's
README and docs at build time, using a small Zola component. That way the
documentation lives in one place and the site never drifts from it.

Next I want to spend time using all of this rather than building it, and see
which rough edges show up first.
