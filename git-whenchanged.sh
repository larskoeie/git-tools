#!/usr/bin/php

<?php
$input_data = stream_get_contents(STDIN);

$lines = explode("\n", $input_data);
$g = [];

foreach ($lines as $line) {
	$path = NULL;
	if (substr($line, 0, 1) == "\t") {
		if (preg_match(';   ([^ ]+)$;', $line, $m)) {
			$path = trim($m[1]);
		}
                if (preg_match(';\t([^ ]+)$;', $line, $m)) {
                        $path = trim($m[1]);
                }
		if ($path) {
			if (file_exists($path)) {

				$filemtime = filemtime($path);
				$days = round((time() - $filemtime) / 86400);
				$days = str_pad($days, 3, ' ', STR_PAD_LEFT);
				$line = "\t" . date(DATE_W3C, $filemtime) . "\t" . $days . " days\t" . $line;
			} else {
				$line = "\t\t\t\t\t\t\t" . $line;
				
			}
		} 
		$g[$days][] = $line;

	}

	echo $line . "\n";



}

if (0) {

	ksort($g);

	echo "\nAll changes sorted by age:\n";
	foreach ($g as $days => $lines) {
		foreach ($lines as $line) {
			echo $line . "\n";
		}
	}

}

echo "\n";

