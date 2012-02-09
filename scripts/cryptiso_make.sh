#!/bin/sh
# Required packages : aespipe mkisofs loop-aes-utils
if [ ! -d $1 ]; then
	exit
fi

mkisofs -r $1 | aespipe -e aes256 > $1.iso

