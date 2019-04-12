cat data/* | awk -F'|' '{print $2}' | cut -d',' -f2 | sort | uniq -c | sort
