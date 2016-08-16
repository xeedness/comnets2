#!/usr/bin/env python

import string
from scipy.stats import expon
import scipy
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
    # * 0.001: turn into kb for easier handling
    traces = [int(string.strip(t, "\n")) for t in raw_traces]

print (max(traces))
# calculate mean & lambda for reference
mean = np.mean(traces)
print("[WIP] distribution mean: ", mean)
print("[WIP] lambda:            ", 1/mean)

# do the distribution fitting dance
dist = getattr(scipy.stats, "expon")
param = dist.fit(traces)
lambda_, mean = dist.fit(traces)
print("mean   (2. versuch):     ", mean)
print("lambda (2. versuch):     ", lambda_)
print param

size = len(traces)
#pdf_fitted = dist.pdf(scipy.arange(size), *param[:-2], loc=param[-2], scale=param[-1]) * size
#pdf_fitted = dist.pdf(scipy.arange(size), scale=param[-1]) * size
pdf_fitted = dist.pdf(scipy.arange(size), scale=size) *size

print pdf_fitted

# Set up the matplotlib figure
f, ax = plt.subplots(figsize=(8, 6))
ax.set_ylabel("# of occurrences")
ax.set_xlabel("requested size (in kB)")

# plot trace values
sns.distplot(traces, kde=False, rug=False)
# plot expon(lambda_) for comparison
sns.plt.plot(pdf_fitted, label='exponential')
sns.plt.plot(lambda_, expon.pdf(lambda_), 'r-', lw=5, alpha=0.6, label='foo')

sns.plt.legend(loc='upper right')
sns.plt.show()
