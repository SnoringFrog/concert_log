#!/usr/bin/env bash

echo "Birth: " $(./months_between.py '11/27/91' "$1")
echo "Sep14: " $(./months_between.py '08/29/14' "$1") #Uses 8/29 so that an input date for the month I just finished will include that month as finished

