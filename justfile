default:
    @just --list

theme:
    nix run .#generate-camden-scss

serve: theme
    zola serve

build: theme
    zola build

check:
    zola check

clean:
    rm -rf public

rebuild: clean build

fmt:
    nix fmt

dev: check serve
