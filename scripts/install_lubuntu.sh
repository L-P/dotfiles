#!/usr/bin/env sh
# First thing to execute after a fresh lubuntu install (≥ 12.10)

export GH_DOTFILES='https://raw.github.com/L-P/dotfiles/master'
export ETCCONF='/etc/etckeeper/etckeeper.conf'


main() {
    init_etckeeper
    init_dotfiles
    install_packages
    update_alternatives
    install_npm_packages
    enable_lighttpd_mods
}


init_etckeeper() {
    # git is now officially the first thing I install
    sudo apt-get update
    sudo apt-get install git etckeeper -y

    sudo sed -i 's/#VCS="git"/VCS="git"/' "$ETCCONF"
    sudo sed -i 's/VCS="bzr"/#VCS="bzr"/' "$ETCCONF"
    sudo etckeeper init
    sudo etckeeper commit
}


init_dotfiles() {
    cd "$HOME"

    wget  "$GH_DOTFILES/scripts/install_dotfiles.sh" -O install_dotfiles.sh
    chmod +x install_dotfiles.sh
    ./install_dotfiles.sh
    touch .bash_local .zsh_local
}


install_packages() {
    cd "$HOME/.dotfiles"

    # Remove packages first to avoid downloading useless packages during the update
    sudo apt-get purge $(cut bad-packages.txt -d '#' -f 1) -y
    sudo apt-get autoremove -y
    sudo apt-get install $(cut packages.txt -d '#' -f 1) -y
    sudo apt-get dist-upgrade -y

    # Install libdvdcss, this can't be done via apt-get because lawyers sucks
    sudo /usr/share/doc/libdvdread4/install-css.sh

    sudo apt-get autoremove -y
    sudo apt-get autoclean -y

    # This can't be done in init_dotfiles unless we install zsh beforehand
    chsh -s $(which zsh)
}


update_alternatives() {
    sudo update-alternatives --set editor $(which vim.basic)
    sudo update-alternatives --set x-www-browser $(which firefox)
    sudo update-alternatives --set gnome-www-browser $(which firefox)
}


install_npm_packages() {
    old_umask="$(umask)"
    umask 022

    sudo npm install -g jshint less yui-compressor

    umask "$old_umask"
}

enable_lighttpd_mods() {
    sudo lighttpd-enable-mod fastcgi fastcgi-php evhost
}


main
