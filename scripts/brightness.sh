#!/bin/bash

if [[ -z "$1" || -z "$2" ]]; then
	echo This needs two parameters…
	exit 1
fi

file='/sys/class/backlight/intel_backlight/brightness'
cur=$(cat "$file")

new=$(($cur $1 $2))
echo $new > $file
echo New brightness: $new/$max

