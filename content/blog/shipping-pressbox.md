+++
title = "Shipping pressbox 26.0.0"
date = 2026-11-20
description = "pressbox got its first release, the iPhone app traded lists for tiles, and I cut the Mac app to get it out the door."

[taxonomies]
tags = ["nix", "nixos", "open-source", "rust", "swift", "website"]
+++

Last week ended with a plan to get the apps onto real devices and cut an actual
26.0.0 release. Half of that happened. The server shipped, and the iPhone app
got a lot closer by getting smaller.

## pressbox 26.0.0

On Tuesday I tagged [pressbox](https://red-oxide.org/projects/pressbox/) 26.0.0,
its first real release. The full announcement is on
[red-oxide.org](https://red-oxide.org/news/pressbox-26-0-0/), so here's the
short version: a Rust server you configure in NixOS, podcasts with chapters,
transcripts, and a shared Up Next queue, and terminal and desktop clients. The
0.1.0 from my first roundup was never tagged, so it was folded into 26.0.0
rather than kept as its own entry in the changelog.

Most of the days before the tag went into hardening rather than features.
pressboxd fetches whatever URLs its feeds point at, so it now refuses to fetch
linked pages from private addresses, keeps only http and https links, and caps
how many entries it takes from each feed. A feed whose entries can't be stored
now backs off instead of retrying every cycle. The clients' token files and the
mpv socket are private to the user. The project also has a `SECURITY.md` with a
private way to report problems.

A few smaller things went in on the way:

- Time handling moved from chrono to jiff.
- A feed that answers 304 Not Modified keeps its artwork instead of losing it
  after the first quiet fetch.
- Transcripts in the show's own language are preferred.
- `just release` tags and publishes a release from my machine.
- The coverage threshold in CI went from 100% down to 95%.
- The server stays AGPL-3.0-only, after I weighed GPL-3.0-only for a while.

## pressbox-darwin: tiles, and less Mac

The iPhone app changed shape this week. Feeds and items are tiles now instead of
lists, with artwork where a feed has it and the title on the tile where it
doesn't. The feed list is grouped into sections by tag, so a feed with several
tags shows up in each of them. Getting the tiles without artwork right took most
of a Saturday and more commits than I'd like to admit, all of them adjusting one
shade of orange.

The bigger change was scope. pressbox-darwin builds for iPhone only for now, and
the Mac code is gone entirely. Getting one platform right comes first. The iPad
code stayed, and the Mac can come back later, though watchOS and an Apple TV app
for podcasts and video are ahead of it in line.

Its changelog now treats 26.0.0 as its first release, and pushing a tag uploads
a build to TestFlight. I'm still testing it by hand before I tag it.

## Plans in issues

pressbox and pressbox-darwin both had a `TODO.md` for about two days before I
moved everything into GitHub issues and milestones. The next server release,
26.1.0, is mostly what the apps need from it: syncing only what changed since
the last request, a server-side artwork cache so the tile layouts don't hit
third-party hosts, managing devices over the API, and a generated API
description the Swift and Kotlin clients can test against. If it slips into
January, it becomes 27.0.0.

## And the sites

Both this site and red-oxide.org now put an image in their Atom feeds: my
picture here, and the logo there. That came from a `feed_image` option added to
the shared rivet theme. red-oxide.org also published its first real news post,
[Hello, red-oxide](https://red-oxide.org/news/hello-red-oxide/), which explains
the move from my personal GitHub account.

Next up is tagging pressbox-darwin 26.0.0 once I trust it, and then the 26.1.0
server work.
