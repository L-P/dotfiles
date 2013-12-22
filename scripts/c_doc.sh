#!/usr/bin/env bash

# http://vim.wikia.com/wiki/PHP_online_help
browser="$(which firefox)"
url="http://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search="

if ($browser -remote "ping()" &> /dev/null); then
    $browser -remote "openurl($url$1, new-tab)" &> /dev/null & disown
else
    $browser $url$1 &> /dev/null & disown
fi

