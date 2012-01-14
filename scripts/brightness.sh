#!/bin/bash

if [[ -z "$1" || -z "$2" ]]; then
	echo This needs two parameters…
	exit 1
fi

dir='/sys/class/backlight/intel_backlight/'
file_cur="$dir/brightness"
file_max="$dir/max_brightness"

cur=$(cat "$file_cur")
max=$(cat "$file_max")

new=$(($cur $1 $2))
if [[ $new -gt $max ]]; then
	new=$max
fi

echo $new > $file_cur
echo New brightness: $new/$max

