<?php

function template($v, $max, string $format, $weight = 1.0): string
{
    $templates = [
        $format,
        "<span color='yellow'>$format</span>",
        "<span color='orange'>$format</span>",
        "<span color='red'>$format</span>",
    ];

    // If weight is negative, it means the higher the v the better, invert colors
    $ratio = $weight > 0
        ? ($v / $max) * $weight
        : (($max - $v) / $max) * -$weight
    ;

    $index = max(0, floor(min($ratio, 1.0) * (count($templates) - 1)));

    return sprintf($templates[$index], $v);
}
