#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from mpl_toolkits.axes_grid1 import host_subplot
from rate import *
from scipy.optimize import curve_fit
import sympy


#define dictionaries for data in format r, rho_analytic, rho_mapped, d_effective
rep_data = {}
att_data = {}
for i in range(3):
    rep_data[i] = np.loadtxt('mapping_output/repulsive_'+`i`+'.tsv')
    att_data[i] = np.loadtxt('mapping_output/attractive_'+`i`+'.tsv')

#Direct input 
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern, MnSymbol}"]
#Options
params = {'text.usetex' : True,
          'font.size' : 10,
          'legend.fontsize' : 10,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params) 
height = 0.8
print 'plot 1'
fig1 = mp.figure()
fig1.set_size_inches(3.54,height*3.54) 

ax1 = fig1.add_subplot(111)
ax1b = ax1.twinx()
l1 = ax1b.plot(rep_data[0][1:-1,0], rep_data[0][1:-1,3], zorder = 2, color = '#CC0000', label = r'$r_d = 0.25$')
l2 = ax1b.plot(rep_data[1][1:-1,0], rep_data[1][1:-1,3], zorder = 3, color = '#FF3333', label = r'$r_d = 2.5$')
l3 = ax1b.plot(rep_data[2][1:-1,0], rep_data[2][1:-1,3], zorder = 4, color = '#FF9999', label = r'$r_d = 250$')

ax1.text(0.02, 0.95, 'A)', zorder = 5, transform=ax1.transAxes, fontsize=12, va='top')
l4 = ax1.plot(rep_data[0][:,0], rep_data[0][:,4], '--', zorder = 6, color = '#A0A0A0', label = r'$U_m(r)$')

ax1.set_ylim([0,2])
ax1.set_yticks([0,1,2])
ax1.set_xlim([0,20])
ax1.set_ylabel(r'$D_{eff}$')

ax1b.set_ylabel(r'$U_m$')
ax1b.set_yticks([0,0.6,1.2])

lns = l1+l2+l3+l4
labs = [l.get_label() for l in lns]
ax1.legend(lns, labs, loc='lower right')

mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))

ax1.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

ax1.set_zorder(ax1b.get_zorder()+1)
ax1.patch.set_visible(False)


mp.savefig("mapping_d.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
print 'plot 2'
fig2 = mp.figure()
#You must select the correct size of the plot in advance
fig2.set_size_inches(3.54,height*3.54) 
ax2 = fig2.add_subplot(111)
ax2b = ax2.twinx()

l1 = ax2b.plot(rep_data[0][1:-1,0], rep_data[0][1:-1,1], zorder = 2, color = '#0080FF', label = r'$r_d = 0.25$')
l2 = ax2b.plot(rep_data[1][1:-1,0], rep_data[1][1:-1,1], zorder = 3, color = '#66B2FF', label = r'$r_d = 2.5$')
l3 = ax2b.plot(rep_data[2][1:-1,0], rep_data[2][1:-1,1], zorder = 4, color = '#99CCFF', label = r'$r_d = 250$')

ax2.text(0.02, 0.95, 'B)', zorder = 5, transform=ax2.transAxes, fontsize=12, va='top')
l4 = ax2.plot(rep_data[0][:,0], rep_data[0][:,4], '--', zorder = 6, color = '#A0A0A0', label = r'$U_m(r)$')

ax2.set_zorder(ax2b.get_zorder()+1)
ax2.patch.set_visible(False)

ax2.set_ylim([0,2])
ax2.set_yticks([0,1,2])
ax2.set_xlim([0,20])
ax2.set_ylabel(r'$\rho_{m}$')

ax2b.set_ylabel(r'$U_m$')
ax2b.set_yticks([0,0.6,1.2])
mp.xticks([1,6,11])

lns = l1+l2+l3+l4
labs = [l.get_label() for l in lns]
ax2.legend(lns, labs, loc='lower right')

mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))

ax2.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

lns = l1+l2+l3+l4
labs = [l.get_label() for l in lns]
ax2.legend(lns, labs, loc='lower right')


mp.savefig("mapping_densities.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            ) 
