# chris

Source for [chris.palmerlife.online](https://chris.palmerlife.online), my
personal site: a [Zola](https://www.getzola.org) site using the shared
[rivet](https://github.com/red-oxide/rivet) theme, with a dev shell and
formatting from Nix, deployed by Cloudflare Pages.

## Working on it

```sh
git submodule update --init   # fetch rivet into themes/rivet (or clone with --recursive)
nix develop      # Zola and just (or let direnv load it)
just serve       # http://127.0.0.1:1111, reloads on save
just build       # into public/
just check       # Zola's link checks
just fmt         # devfmt's formatters (Nix, Markdown, HTML, Sass, TOML, ...)
just update      # update every flake input
just update-rivet # move themes/rivet to rivet's latest commit
```

## Layout

```
content/           pages, blog posts and projects
themes/rivet/      the shared theme (git submodule): templates, styles, palette
static/            avatar and favicons, copied as-is
nix/               flake-parts module: dev shell
zola.toml          site config ([extra.rivet] drives nav, hero, footer)
```

## Project pages

Pages under `content/projects/` pull their documentation from each project's
repository when the site builds, so they stay in step with the READMEs. A page
uses `template = "project.html"` and lists the files in its front matter:

```toml
[extra]
remote_md = [{ url = "https://raw.githubusercontent.com/chrisppy/<repo>/master/README.md", strip_title = true, stop_at = "## Development", links = { "./docs/usage.md" = "#usage" }, base = "https://github.com/chrisppy/<repo>/blob/master/" }]
```

Each entry is passed to rivet's `remote_md` component in
`themes/rivet/templates/components.html`, which documents the options. Keep the
list on one line: the Markdown formatters would otherwise escape the brackets.

## Deployment

Cloudflare Pages builds every push to `master` with `zola build`.

- **Zola version:** Cloudflare uses its `ZOLA_VERSION` environment variable;
  keep it equal to `extra.zola_version` in `zola.toml`. The Build workflow fails
  when nixpkgs' Zola (the dev shell's) differs from it.
- **Nightly rebuild:** the Rebuild site workflow calls a Cloudflare deploy hook
  (the `CF_PAGES_DEPLOY_HOOK` secret) so project pages pick up changes in their
  repositories.
- **Checks:** the Build workflow builds the site and runs `nix flake check` on
  every push, pull request and flake update.

## License

The code (templates, styles, Nix and scripts) is under the
[MIT License](LICENSE) and the written content under
[CC BY 4.0](LICENSE-CONTENT).
