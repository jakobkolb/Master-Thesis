#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
import matplotlib.colors as co
import matplotlib.cm as cm
import math
from scipy.optimize import curve_fit
from rate import *
import sympy
import pickle

kt = 1.
d = 1.
l = 5
g = 1.

uvalues = [-9.,-3.,-1.,0,1.,3.,6.]
colors = ['#CC0000','#FF3333','#FF9999','#A0A0A0', '#99CCFF', '#66B2FF','#0080FF']
#uvalues = [1]

rdvalues = 10**np.arange(-2,4,.1)

rates = np.zeros((np.shape(uvalues)[0],np.shape(rdvalues)[0],3))

for i, u in enumerate(uvalues):
    for j, rd in enumerate(rdvalues):
        rates[i,j,0] = calc_rate(u,rd,g,l,kt,d)
for j, rd in enumerate(rdvalues):
    rates[0,j,1] = calc_att_limit(rd,g,l,kt,d)
    rates[0,j,2] = calc_rep_limit(rd,g,l,kt,d)
#Direct input
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern}"]
#Options
params = {'text.usetex' : True,
            'font.size' : 11,
            'font.family' : 'lmodern',
            'text.latex.unicode': True,
            }
mp.rcParams.update(params)




fig = mp.figure()
ax1 = fig.add_subplot(111)

for i, u in enumerate(uvalues):
    ax1.plot(rdvalues, rates[i,:,0], color = colors[i],label='$U_1 = $'+('%1.0f' %u)+'$~k_B T$')
ax1.plot(rdvalues, rates[0,:,1],'k--', label=r'$U_1 \rightarrow -\infty$')
ax1.plot(rdvalues, rates[0,:,2], 'k:', label=r'$U_1 \rightarrow \infty$')


ax1.set_ylim([0.4,1.4])
ax1.set_xscale('log')
ax1.set_xlabel(r'$r_d$')
ax1.set_ylabel(r'$k/k_S$')

box = ax1.get_position()
ax1.set_position([box.x0, box.y0, box.width * 0.8, box.height])

# Put a legend to the right of the current axis
ax1.legend(loc='center left', bbox_to_anchor=(1, 0.5))

fig.set_size_inches(3.54*1.2,3.54)

mp.savefig("u1_dependence.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )
