#!/usr/bin/php

<?php
/*
Use like this :

[alias]
        grepdiff = !git diff | git-grepdiff.sh $1

*/

$input_data = stream_get_contents(STDIN);

$q = $argv[1];
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
                exec('git show ' . $hash . '|grep -B 1 -A 1 "' . $q . '"', $result);

foreach ($result as $line) {
        if (substr($line, 0, 3) == '+++') {
                // file name
                echo $line . "\n";
        } elseif (substr($line, 0, 2) == '--') {
                echo str_replace($q, "\033[0;7m" . $q . "\033[27m", $line) . "\n";
        } elseif (substr($line, 0, 1) == '+') {
                $line = "\033[0;32m" . $line . "\033[0m";
                echo str_replace($q, "\033[0;7m" . $q . "\033[27m\033[32m", $line) . "\n";
        } elseif (substr($line, 0, 1) == '-') {
                $line = "\033[0;31m" . $line . "\033[0m";
                echo str_replace($q, "\033[0;7m" . $q . "\033[27m\033[31m", $line) . "\n";
        } else {
                echo str_replace($q, "\033[0;7m" . $q . "\033[27m", $line) . "\n";
        }
        
        }
        }

}

echo "\n\n";
