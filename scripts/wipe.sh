#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: wipe <device>"
	exit 1
fi

if [ ! -w "$1" ]; then
	echo "Please check that '$1' exists and is writable."
	exit 2
fi

size=$(fdisk -l "$1" 2> /dev/null | grep "$1:" | cut -d ' ' -f 5)

echo Wiping…
pv -s $size /dev/urandom | dd of="$1" bs=1M conv=notrunc 2>/dev/null
echo

echo Blanking the first 10 MB…
dd if="/dev/zero" of="$1" bs=1M count=10 conv=notrunc 2>/dev/null
echo

# If this fails to show only three lines, it means that the device is dead.
# This showed me that 3 of my USB keys were dead (random bytes were not set).
echo "Hexdump, this should show only three lines:"
dd if="$1" count=10 bs=1M 2> /dev/null | hexdump -C | head

