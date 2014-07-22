#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
import math
from scipy.optimize import curve_fit
from rate import calc_rate
import sympy
import pickle

kt = 1.
d = 1.
u = 3.

rdvalues = 10**np.arange(-4.,5.,0.01)
tvalues = 10**np.arange(-2.,2.,0.1)
gvalues = 10**np.arange(-2.,2.,0.1)
arates = np.zeros((np.shape(rdvalues)[0],2))
kmax = np.zeros((np.shape(tvalues)[0],np.shape(gvalues)[0],4))
fit_parameters = np.zeros((np.shape(gvalues)[0],3))

print tvalues
print gvalues

istop = 10
istart = 0

for g_index, g in enumerate(gvalues):
    for t_index, t in enumerate(tvalues):
        print g_index, t_index
        arates[:,:] = 0.
        for i in range(istart,istop,1):
            rate = calc_rate(u,rdvalues[i],g,t,kt,d)
            if math.isnan(rate):
                break
            arates[i,1] = rate
            arates[i,0] = rdvalues[i]
        indices = np.argmax(arates[:,1])
        kmax[t_index,g_index,:] = [t, g, arates[indices,0], arates[indices,1]]
        print kmax[t_index,g_index]
        istop = min(indices + 50,np.shape(rdvalues)[0])
        istart = max(0,indices-50)

with open('resonance_data.p', 'w') as fo:
    pickle.dump(kmax,fo)


