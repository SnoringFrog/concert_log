cat data/* | awk -F'|' '{print $1}' | sort | uniq -c
