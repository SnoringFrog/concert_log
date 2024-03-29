#!/usr/bin/env bash

months=('Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec')
days_in_months=(31 29 31 30 31 30 31 31 30 31 30 31)
data_dir="${HOME}/personal/concert_log/data"
outfile="${HOME}/personal/concert_log/missed_dates.txt"

echo `date` > $outfile

for m in {1..12}; do
	printf -v pm "%02d" $m #get zero-padded month
	days_seen=$(awk -F'|' '{print $1}' $data_dir/*_$pm | sort -u)

	# Zero-padded sequence for number of days in month
	remaining_days=($(seq -f "%02g" 1 ${days_in_months[$((m-1))]}))

	# Remove days seen from days in month
	for ds in ${days_seen[@]}; do
		remaining_days=(${remaining_days[@]//*$ds*})
	done


	echo "${months[$((m-1))]}:" | tee -a $outfile
	echo ${remaining_days[@]} | tee -a $outfile
	echo | tee -a $outfile
done
