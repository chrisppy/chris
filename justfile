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

update:
    nix flake update

# Pull the newest rivet into themes/rivet (commit the result)
update-rivet:
    git submodule update --remote themes/rivet

update-input input:
    nix flake update {{ input }}
