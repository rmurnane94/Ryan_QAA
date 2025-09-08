#!/usr/bin/env python

import argparse

#defining argparse variables
def get_args():
     parser = argparse.ArgumentParser(description="inputs and parameters")
     parser.add_argument("-f", "--sam_file", help="sam file to input", required=True)
    
    
     return parser.parse_args()
	
args = get_args() 

mapped_reads = 0
unmapped_reads = 0
with open(args.sam_file, 'r') as read_file:
    for line in read_file:
        line = line.strip()

        if line[0] != '@':
            line = line.split()
            flag = int(line[1])

            if((flag & 256) != 256):
                primary = True

                if((flag & 4) != 4):
                    mapped = True

                    mapped_reads += 1

                else:
                   unmapped_reads += 1
        

print(f"mapped reads: {mapped_reads}")
print(f"unmapped reads: {unmapped_reads}")

            