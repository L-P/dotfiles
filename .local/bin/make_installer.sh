#!/usr/bin/env bash

function main() {
    local -r repo='https://github.com/L-P/dotfiles.git'
    local -r tmp="$(mktemp -d)"
    local -r cwd="$(pwd)"

    git clone "$repo" "$tmp" --depth=1
    pushd "$tmp"
    git submodule update --init --recursive
    find . -type d -name '.git' -exec rm -rf {} +
    pushd ..
    makeself "$tmp" "$cwd/dotfiles" dotfiles ./loader
    popd; popd
    rm -Rf "$tmp"
    return 0
}

main
