#!/usr/bin/env bash

function main() {
    local repo='https://github.com/L-P/dotfiles.git'
    local tmp='/tmp/dotfiles'
    local pwd="$(dirname "$0")"

    git clone "$repo" "$tmp"
    pushd "$tmp"
    git submodule update --init --recursive
    rm -Rf .git
    cd ..
    makeself "$tmp" "$pwd/$(basename "$tmp").run" dotfiles ./loader
    popd
    mv "$tmp.tgz" .
    return 0
}

main
