#!/usr/bin/env python

import matplotlib.pyplot as plt

forward_312 = '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/312_forward_counts.txt'

reverse_312 = '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630312_files/trimmomatic/312_reverse_counts.txt'

forward_410 = '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/410_forward_counts.txt'

reverse_410 = '/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/SRR25630410_files/trimmomatic/410_reverse_counts.txt'


#function to pull info from files
def get_length_counts(count_file):
    new_dict = {}
    with open(count_file, 'r') as current_file:
        for line in current_file:
            line = line.strip()
            line = line.split()

            read_length = int(line[1])
            length_count = int(line[0])

            new_dict[read_length] = length_count
    
    return new_dict


#pull info from files
dict_forward_312 = get_length_counts(forward_312)
dict_reverse_312 = get_length_counts(reverse_312)

dict_forward_410 = get_length_counts(forward_410)
dict_reverse_410 = get_length_counts(reverse_410)


#sort the dictionaries
sorted_dict_forward_312 = dict(sorted(dict_forward_312.items()))
sorted_dict_reverse_312 = dict(sorted(dict_reverse_312.items()))

sorted_dict_forward_410 = dict(sorted(dict_forward_410.items()))
sorted_dict_reverse_410 = dict(sorted(dict_reverse_410.items()))


def create_plots(dict_forward, dict_reverse, name):
    lengths_for = [x for x in dict_forward]
    counts_for = [dict_forward[x] for x in dict_forward]

    lengths_rev = [x for x in dict_reverse]
    counts_rev = [dict_reverse[x] for x in dict_reverse]

    fig, ax=plt.subplots()
    ax=plt.bar(lengths_for,counts_for,label='R1', alpha=0.5)
    ax=plt.bar(lengths_rev,counts_rev,label='R2', alpha=0.5)
    plt.legend(loc='upper left')
    plt.title(f"{name} Trimmed Read Length Distribution for R1 and R2")
    plt.xlabel("Read Length")
    plt.ylabel("Count")
    plt.savefig(f'/projects/bgmp/rmurnane/bioinfo/Bi623/Ryan_QAA/SRR_stuff/{name}_files/trimmomatic/{name}_trimmed_lengths.png')
    plt.clf()


create_plots(sorted_dict_forward_312,sorted_dict_reverse_312,'SRR25630312')

create_plots(sorted_dict_forward_410,sorted_dict_reverse_410,'SRR25630410')






