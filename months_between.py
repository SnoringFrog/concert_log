#!/usr/bin/python3

import sys
from datetime import datetime
from dateutil import relativedelta

def date_diff(m1, m2): #month1, month2
    #print(abs(m1.year - m2.year) * 12)
    #return (abs(m1.year - m2.year) * 12) - m1.month - m2.month
    return relativedelta.relativedelta(max(m1,m2), min(m1,m2))

def convert_input(input_date):
    date_list = input_date.split("/")

    month = int(input_date.split("/")[0])

    if len(date_list) == 2:
        day = 29 #defaults to 29 to work for all months and with my months_since script
        year = int(input_date.split("/")[1])
    else:
        day = int(input_date.split("/")[1])
        year = int(input_date.split("/")[2])
    
    if year > 90:
        year+=1900
    else:
        year+=2000

    return datetime(year,month,day)

if len(sys.argv) != 3:
    print("Error: Not enough arguments\nInput two dates in mm/dd/yy format.")
    exit(1)
elif "/" not in sys.argv[1] or "/" not in sys.argv[2]:
    print("Error: Wrong format\nInput two dates in mm/dd/yy format.")
    exit(2)

difference = date_diff(convert_input(sys.argv[1]), convert_input(sys.argv[2]))

print(difference.years*12 + difference.months)
