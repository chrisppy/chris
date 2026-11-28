dev := if env("IN_NIX_SHELL", "") == "" { "nix develop --command " } else { "" }

default:
    @just --list

serve:
    zola serve

build:
    zola build

check:
    zola check

clean:
    rm -rf public

rebuild: clean build

fmt:
    nix fmt

# Update the pins (tack): all, or the ones named, like `just update nixpkgs`
update *names:
    {{ dev }}tack update {{ names }}

# Show which pins have newer upstream revisions
look:
    {{ dev }}tack look

# Run any other tack command
tack *args:
    {{ dev }}tack {{ args }}

# Pull the newest rivet into themes/rivet (commit the result)
update-rivet:
    git submodule update --remote themes/rivet
