#!/bin/sh

# To use when a program asks for a GUI editor.
terminator -x bash -c "vim -p '$1'"

