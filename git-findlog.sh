#!/usr/bin/php

<?php
/*
Use like this :

[alias]
        findlog = !git log -- $1 | git-findlog.sh $1


*/

$input_data = stream_get_contents(STDIN);

$path = $argv[1];

$lines = explode("\n", $input_data);

foreach ($lines as $lineNumber => $line) {
        if (preg_match('/commit ([0-9a-f]+)/', $line, $m)) {
                $dateline = $lines[$lineNumber + 2];
                $commitline = $lines[$lineNumber + 4];
                $hash = $m[1];
                echo "\n";
                echo "$line\n";
                echo "$dateline \n";
                echo "$commitline \n";
                $result = [];
                exec('git show ' . $hash . ' -- ' . $path, $result);

foreach ($result as $line) {

  if (substr($line, 0, 2) == '--') {
		echo $line . "\n";
        } elseif (substr($line, 0, 1) == '+') {
                $line = "\033[0;32m" . $line . "\033[0m";
		echo $line . "\n";
        } elseif (substr($line, 0, 1) == '-') {
                $line = "\033[0;31m" . $line . "\033[0m";
		echo $line . "\n";
        } else {
		echo $line . "\n";
        }
}
}
}

echo "\n\n";







