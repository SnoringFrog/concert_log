#!/usr/bin/env bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 month_number"
fi

if [ ${#1} -lt 2 ]; then
	month="0$1"
else
	month="$1"
fi

files=(data/*_${month})
cat "${files[@]}" | awk -F'|' '{print $1}' | sort -u -n
