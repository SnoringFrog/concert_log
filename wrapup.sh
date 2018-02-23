#!/usr/bin/env bash
# Take input as mm/dd/[yy]

# Date related variables
date=$(date -d "$1" +%m/%d/%y)
day=$(date -d "$1" +%d)
month=$(date -d "$1" +%m)
year=$(date -d "$1" +%Y)
month_name=$(date -d "$1" +%B)

date_file="data/$(date -d "$1" +%Y_%m)"
date_files_current_year=$(seq -f"data/${year}_%02g" 1 $month)
date_files_prev_years="$(seq -f"data/%g*" 1991 $((year-1))) $date_files_current_year data/unknown_date"
date_files_since_sep14="$(seq -f"data/2014_%02g" 9 12) $(seq -f"data/%g*" 2015 $((year-1))) $date_files_current_year"

#Uses 8/29 so that an input date for the month I just finished will include that month as finished
months_since_sep14=$(./months_between.py '08/29/14' "$date") 
months_since_birth=$(./months_between.py '11/27/91' "$date")

unique_bands_count=$(./count_unique_bands $date_file)
unique_venues_count=$(./count_unique_venues $date_file)

shows_in_month=$(wc -l $date_file |  awk '{print $1}')
shows_in_year=$(cat $date_files_current_year | wc -l)
shows_since_birth=$(cat $date_files_prev_years 2>/dev/null | wc -l)
shows_since_sep14=$(cat $date_files_since_sep14 2>/dev/null | wc -l)

avg_shows_per_week=$(awk '{printf "%.2f", $1/$2}' <<< "$shows_in_year $(date -d "$1" +%U)")
days_to_shows=$(awk '{printf "%.2f", $1/$2}' <<< "$(date -d "$1" +%j) $shows_in_year")
avg_shows_since_birth=$(awk '{printf "%.2f", $1/$2}' <<< "$shows_since_birth $months_since_birth")
avg_shows_since_sep14=$(awk '{printf "%.2f", $1/$2}' <<< "$shows_since_sep14 $months_since_sep14")

# Counting new bands/venues:
cur_year=$(seq -f"data/${year}_%02g" 1 $(printf "%02d" $(($month-1)))) # excludes this month
date_files_for_new_counts="$(seq -f"data/%g*" 1991 $((year-1))) $cur_year data/unknown_date"
new_bands_count=$(./new_bands.py "$(./unique_bands <<<$(cat $date_files_for_new_counts 2>/dev/null))" "$(./unique_bands $date_file)")

# Similar story for venues, but I'll need a new script since mine's built for output. 
#	That script should do venuename-cityname, to cover for things like House of Blues or Upper Room
#	since there are multiple venues with those names.


###########################

echo -e "Show count: $shows_in_month\n"
echo -e "Cities/Venues:"
./city_venue_list "$date_file"
echo ""

echo -e "Bands (highlights tagged): $(./unique_bands $date_file)\n"

echo "New venues: /$unique_venues_count"
echo "New bands: $new_bands_count/$unique_bands_count"

echo -e "-----------------------------------------------\n"
echo "$month_name wrap up!

[quick summary]

Shows in $month_name: $shows_in_month
Shows in $year so far: $shows_in_year

Notable new artists to me:

Best show:

Shows I was bummed to miss:

[extra categories]

Other random facts/stats:
This month was my first time at [x] of the $unique_venues_count venues I went to.
This month was my first time seeing $new_bands_count of the $unique_bands_count bands I saw perform live.
Avg shows per week for $year: $avg_shows_per_week
Days/shows ratio so far for $year: $days_to_shows:1
Approximate avg shows per month since birth: $avg_shows_since_birth
Avg shows per month since Sept '14: $avg_shows_since_sep14

Other months: https://www.facebook.com/espiekarski/notes?lst=100001385057628%3A1405230010%3A1484594066
"
