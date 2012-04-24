#!/usr/bin/env bash

# http://vim.wikia.com/wiki/PHP_online_help
browser="$(which firefox)"

if ($browser -remote "ping()" &> /dev/null); then
	$browser -remote "openurl(http://www.php.net/$1, new-tab)" &> /dev/null & disown
else
	$browser http://www.php.net/$1 &> /dev/null & disown
fi

