#!/bin/bash

on=$(synclient | grep TouchpadOff | grep 1)
if [[ -z $on ]]; then
    synclient TouchpadOff=1
    echo 'Turned off'
else
    synclient TouchpadOff=0
    echo 'Turned on'
fi

