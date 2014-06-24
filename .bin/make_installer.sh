#!/usr/bin/env bash

function main() {
    local repo='https://github.com/L-P/dotfiles.git'
    local tmp="$(mktemp -d)"
    local cwd="$(pwd)"

    git clone "$repo" "$tmp"
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
