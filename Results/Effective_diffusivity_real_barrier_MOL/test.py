
#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from mpl_toolkits.axes_grid1 import host_subplot
from rate import *
from scipy.optimize import curve_fit
import sympy

reds = ['', '#CC0000', '#FF3333', '#FF6666', '#FF9999']
blues = ['','#004C99', '#0080FF', '#66B2FF', '#CCE5FF']

#define dictionaries for data in format r, rho_analytic, rho_mapped, d_effective
rep_data = {}
att_data = {}
for i in range(4):
    rep_data[i] = np.loadtxt('mapping_output/repulsive_'+`i`+'.tsv')
    att_data[i] = np.loadtxt('mapping_output/attractive_'+`i`+'.tsv')

print att_data[2][:,3]-att_data[3][:,3]

height = 0.8

fig3 = mp.figure()
fig3.set_size_inches(3.54,height*3.54) 

ax3 = fig3.add_subplot(111)
ax3b = ax3.twinx()
#l1 = ax3.plot(att_data[0][1:-1,0], att_data[0][1:-1,3], zorder = 4, color =reds[1], label = r'$r_d = 10^{-3}$')
#l2 = ax3.plot(att_data[1][1:-1,0], att_data[1][1:-1,3], zorder = 3, color =reds[2], label = r'$r_d = 10^{-1}$')
l3 = ax3.plot(att_data[2][1:-1,0], att_data[2][1:-1,3] - att_data[3][1:-1,3], '-', zorder = 1, color = reds[4], label = r'$r_d = 10^{2}$')

ax3.text(0.02, 0.95, 'A)', zorder = 5, transform=ax3.transAxes, fontsize=12, va='top')
l5 = ax3b.plot(att_data[0][:,0], att_data[0][:,4], '--', zorder = 6, color = '#A0A0A0', label = r'$U_m(r)$')

ax3.set_xlim([0,20])
ax3.set_ylabel(r'$D_{eff}$')

ax3b.set_ylabel(r'$U_m$')
ax3b.set_yticks([0,-0.5,-1.0,-1.5])

lns = l3+l5
labs = [l.get_label() for l in lns]
ax3.legend(lns, labs, loc='lower right')

mp.show()
