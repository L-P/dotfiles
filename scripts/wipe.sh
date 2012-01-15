#!/bin/sh

if [ -z "$1" ]; then
	echo You need to specify the device to wipe.
	exit 1
fi

if [ ! -w "$1" ]; then
	echo please check that "$1" exists and is writable.
	exit 2
fi

size=$(fdisk -l "$1" 2> /dev/null | grep "$1:" | cut -d ' ' -f 5)

echo Wiping…
pv -s $size /dev/urandom | dd of="$1" bs=1M conv=notrunc 2>/dev/null
echo

echo Blanking the first 10 MB…
dd if="/dev/zero" of="$1" bs=1M count=10 conv=notrunc 2>/dev/null
echo

echo Hexdump, this should show only three lines :
dd if="$1" count=10 bs=1M 2> /dev/null | hexdump -C | head

