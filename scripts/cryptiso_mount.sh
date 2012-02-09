#!/bin/sh

sudo modprobe aes
sudo modprobe cryptoloop
sudo mount -t iso9660 /dev/cdrom /media/iso -o loop=/dev/loop0,encryption=aes256

