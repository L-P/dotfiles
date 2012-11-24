#!/usr/bin/env bash

function dot::make_links() {
    local dotpath="~/.dotfiles/"
    local skip=(".dotfiles" ".git" ".gitmodules")

    if [ -z "$HOME" ] || [ -z "$dotpath" ]; then exit 3; fi
    if [ ! "$HOME" ]; then
        echo "Can't write to '$HOME'."
        exit 4
    fi

    for src in $(find "$dotpath" -maxdepth 1 -name '.*' ); do
        local basename="$(basename "$src")"
        local dst="$HOME/$basename"

        for v in $skip; do
            if [[ "$basename" = "$v" ]]; then
                continue 2
            fi
        done

        rm -Rf "$dst"
        ln -s "$src" "$dst"
    done
}

function dot::clone_repos() {
    #local repo='git@github.com:L-P/dotfiles.git' # R/W
    local repo='git://github.com/L-P/dotfiles.git' # RO
    local dest="~/.dotfiles"

    # Create/purge the destination
    mkdir -p "$dest" &> /dev/null
    if [ ! -w "$dest" ];then
        echo "Can't write to '$dest'."
        exit 2
    fi

    # Clone everything
    git clone "$repo" "$dest"
    cd "$dest"
    git submodule init
    git submodule update
}

dot::clone_repos
dot::make_links

