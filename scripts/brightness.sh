#!/bin/bash
# On my laptop (HP dv6) the brightness keys won't work so I have to manually
# set brightness via the intel_backlight/brightness file.
# It sucks a bit but at least it works.

function main() {
	local file_brightness='/sys/class/backlight/intel_backlight/brightness'
	local file_max='/sys/class/backlight/intel_backlight/max_brightness'
	local cur=$(cat "$file_brightness")
	local max=$(cat "$file_max")

	if [ ! -w "$file_brightness" ]; then
		echo "Can't set the new brightness, try with sudo or as root."
		exit 2
	fi

	new=$(($cur $1 $2))
	echo $new > $file_brightness
	echo "New brightness: $new/$max."
}

if [[ -z "$1" || -z "$2" ]]; then
	echo "Usage: brightness <-|+> <delta>"
	exit 1
fi

main $1 $2

