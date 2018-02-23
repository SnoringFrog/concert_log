#!/usr/bin/env python3
import sys

log_file = open("./"+sys.argv[0]+".log", 'w')
prev_list = sys.argv[1].split(', ') # bands seen in previous months
cur_list = sys.argv[2].split(', ') # bands seen this month

prev_count=0
new_count=0

prev_log_list=[]
new_log_list=[]

for band in cur_list:
    if band in prev_list:
        prev_count+=1
        prev_log_list.append(band)
    else:
        new_count+=1
        new_log_list.append(band)

print(new_count)

# Handle logging
print("Seen before ("+str(prev_count)+"): " + ', '.join(sorted(prev_log_list)), file=log_file)
print("New bands ("+str(new_count)+"): " + ', '.join(sorted(new_log_list)), file=log_file)
