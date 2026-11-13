+++
title = "A Week of Pressbox, and a New Home"
date = 2026-11-13
description = "Pressbox grew podcasts, a desktop client, a Mac app, and an Android app, and my projects moved to a new org at red-oxide.org."

[taxonomies]
tags = ["android", "nix", "nixos", "open-source", "quickshell", "rust", "swift", "website"]
+++

Last week's post ended with a plan to spend some time using everything rather
than building it. That lasted about a day. Once pressbox replaced miniflux on my
own server, every rough edge turned into a commit, and the commits turned into
three new clients and a new home for the projects.

## red-oxide

The projects in that post now live in their own GitHub org,
[red-oxide](https://github.com/red-oxide), with a site at
[red-oxide.org](https://red-oxide.org). devfmt, base24-themes, Birdland,
pressbox, pressbox-darwin, and pressbox-android all moved over, and their old
project pages here now redirect there. freecad-flake and my NixOS config stay
under my own name, since they're more personal setup than projects.

The logo is a rusted steel home plate, which also serves as the favicon and the
icon for the pressbox apps. It's licensed CC BY-SA 4.0.

Both sites now share one Zola theme,
[rivet](https://github.com/red-oxide/rivet). It's the same terminal-flavored
layout this site already had, pulled out into its own repo and colored by the
Birdland palette from base24-themes. Changing the scheme in one place recolors
both sites.

## pressbox: podcasts and more clients

Most of the week went into [pressbox](https://red-oxide.org/projects/pressbox/).
The server now understands Podcasting 2.0 media, so feeds can carry episodes
with chapters and transcripts, and playback positions sync between clients. It
also has an Up Next queue in the API, which every client uses.

Before adding anything new I spent a day on tests. Coverage went from 62% to
100%, with every exclusion named, and CI now fails if it drops. There's also a
`just audit` that runs cargo-deny against the whole dependency tree, and today
brought an ammonia update for a new RustSec advisory.

The clients now look like this:

- **The terminal reader** plays podcasts through mpv, with chapters,
  transcripts, and synced positions.
- **pressbox-iced** is a new desktop client built with iced. It lives in the
  pressbox repo and plays audio and video through GStreamer, with MPRIS so media
  keys and Bullpen's media module can control it.
- **[pressbox-darwin](https://red-oxide.org/projects/pressbox-darwin/)** is the
  iOS app, renamed now that it also builds for iPadOS and macOS. It picked up
  podcast playback, downloads for offline listening, an offline queue for
  changes, widgets, Siri and Shortcuts, a Control Center control, a sleep timer,
  and keyboard shortcuts. As of today it requires iOS 27 and macOS 27 and
  follows Apple's Liquid Glass guidelines. CI builds it and uploads it to
  TestFlight, and its unit tests also run on Linux with SwiftPM.
- **[pressbox-android](https://red-oxide.org/projects/pressbox-android/)** is
  new this week: a Kotlin app for Android 12 and later that shares read and
  starred state with the other clients and plays podcasts through Media3. It's
  GPL-3.0-only.

All three pressbox repos also switched to versions of the form
`YY.MINOR.PATCH`, so the first real release will be 26.0.0.

## Birdland

[Birdland](https://red-oxide.org/projects/birdland/) got smaller changes as I
lived with it. Bullpen's modules now float as separate pill islands instead of
sitting on a solid bar, the date has its own module apart from the clock, and
there are new indicators for do not disturb and the idle inhibitor. Lineup has
an `iconSize` option, and the dock's thickness follows it. The notification app
finished its rename from Scoreboard to Announcer, with the old option names
removed.

## The rest

- **base24-themes** has a light variant of the Birdland theme.
- **devfmt** formats Kotlin with ktfmt and Apple property lists and privacy
  manifests with xmllint, both needed by the new apps.
- **Changelogs.** Every repo now has a `CHANGELOG.md` in the Keep a Changelog
  format.
- **My NixOS config** now runs Birdland's lock screen, greeter, notifications,
  and volume pop-ups, and pressbox has fully replaced miniflux.

Next up is getting the apps through TestFlight and onto real devices, and then
an actual 26.0.0 release.
