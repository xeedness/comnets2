#!/usr/bin/env python

import string
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

'''
Read our trace file and plot it to get a rough idea of which distribution to use.
'''

sns.set(style="white", context="talk")

# read traces
with open("trace_13.txt") as f:
    raw_traces = f.readlines()
    traces = [int(string.strip(t, "\n")) for t in raw_traces]

# Set up the matplotlib figure
f, ax = plt.subplots(figsize=(8, 6))
ax.set_ylabel("# of occurrences")
ax.set_xlabel("requested size (in Byte)")

# plot
sns.distplot(traces, kde=False, rug=True);
sns.plt.show()
