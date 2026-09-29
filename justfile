default:
    @just --list

theme:
    nix run .#generate-camden-scss

prepare: theme

serve: prepare
    zola serve

build: prepare
    zola build

check:
    zola check

clean:
    rm -rf public

rebuild: clean build

fmt:
    nix fmt
