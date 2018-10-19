#!/usr/bin/env bash

for file in data/*; do
	results=$(cat "$file" | awk -F'|' '{print $1}' | uniq -c | perl -ne 'print unless /^\s*1/')

	if [ -n "$results" ]; then
		echo $file
		echo "$results"
	fi
done
