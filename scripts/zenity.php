#!/usr/bin/env php
<?php
/** When calling --color-selection on zenity, the color it outputs
 * is broken, every couple of digits is written twice. This script fixes it.
 * Tested with zenity version 3.2.0-0ubuntu1
 *
 * Link this script to /usr/local/bin/zenity and it should be called instead
 * of zenity, if it is not the case, see your $PATH.
 * */

// Let zenity do its thing.
$argv = implode(' ', array_slice($argv, 1));
ob_start();
system("/usr/bin/zenity $argv");
$out = ob_get_clean();

// If the output is a broken color, fix it.
if(preg_match('`^#[0-9A-F]{12}$`i', trim($out))) {
	$color = '#';
	for($i=1; $i<12; $i+=4) {
		$color .= $out[$i];
		$color .= $out[$i+1];
	}

	$out = $color . PHP_EOL;
}

echo $out;

