#!/usr/bin/env bash

function main() {
    local repo='https://github.com/L-P/dotfiles.git'
    local tmp='/tmp/dotfiles'
    local pwd="$(dirname "$0")"

    git clone "$repo" "$tmp"
    pushd "$tmp"
    git submodule update --init --recursive
    find . -type d -name '.git' -exec rm -rf {} +
    pushd ..
    makeself "$tmp" "$pwd/$(basename "$tmp").run" dotfiles ./loader
    popd; popd
    mv "$tmp.run" .
    rm -Rf "$tmp"
    return 0
}

main
