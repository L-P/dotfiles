#!/usr/bin/env bash

function dot::make_links() {
	local dotpath="$1/dotfiles/"

	if [ -z $HOME ] || [ -z $dotpath ]; then exit 3; fi
	if [ ! $HOME ]; then
		echo "Can't write to '$HOME'."
		exit 4
	fi

	for src in $(find "$dotpath" -maxdepth 1 -name '.*' ); do
		if [[ "$(basename "$src")" = '.gitmodules' ]]; then continue; fi
		if [[ "$(basename "$src")" = '.git' ]]; then continue; fi

		local dst="$HOME/$(basename "$src")"

		rm -Rf "$dst"
		ln -s "$src" "$dst"
	done
}

function dot::clone_repos() {
	# Use the 'editable' origin for my users
	local repo=''
	if [[ "$USER" = 'leo' ]] || [[ "$USER" = 'lpeltier' ]]; then
		repo='git@github.com:L-P/dotfiles.git'
	else
		repo='git://github.com/L-P/dotfiles.git'
	fi

	# Create/purge the destination (if needed) and cd into it
	mkdir -p "$1" &> /dev/null
	if [ ! -w "$1" ];then
		echo "Can't write to '$1'."
		exit 2
	fi
	cd "$1"
	rm -Rf dotfiles &> /dev/null

	# Clone everything
	git clone "$repo"
	cd dotfiles
	git submodule init
	git submodule update
}

if [ -z "$1" ]; then
	echo "Usage : install_dotfiles <repo_destination>"
	exit 1
fi

dot::clone_repos "$1"
dot::make_links "$1"

