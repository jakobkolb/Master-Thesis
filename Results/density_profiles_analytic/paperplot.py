#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

list_of_files = range(1,3,1)

dens1 = np.loadtxt('table1.tsv')
dens2 = np.loadtxt('table2.tsv')
dens3 = np.loadtxt('table3.tsv')


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

fig1 = mp.figure()
#You must select the correct size of the plot in advance
fig1.set_size_inches(3.54,0.55*3.54) 

ax1 = fig1.add_subplot(111)
ax1.text(0.02, 0.95, 'A)', transform=ax1.transAxes, fontsize=12, va='top')
mp.plot(dens1[:,0], dens1[:,3], color = '0.55')
mp.plot(dens1[:,0], dens1[:,1], 'r--')
mp.plot(dens1[:,0], dens1[:,2], 'b:')
ax1.set_ylim([0,1.41])
mp.yticks([0,0.5,1.0,1.4])
mp.xticks([1,6,11])
ax1.set_xlim([0,18])
ax1.set_ylabel(r'$\rho_n(r)$')

ax1.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        labelbottom='off') # labels along the bottom edge are off


mp.savefig("d1.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )

fig2 = mp.figure()
#You must select the correct size of the plot in advance
fig2.set_size_inches(3.54,0.55*3.54) 
ax2 = fig2.add_subplot(111)
ax2.text(0.02, 0.95, 'B)', transform=ax2.transAxes, fontsize=12, va='top')
mp.plot(dens2[:,0], dens2[:,3], color = '0.55')
mp.plot(dens2[:,0], dens2[:,1], 'r--')
mp.plot(dens2[:,0], dens2[:,2], 'b:')
ax2.set_ylim([0,1.41])
mp.yticks([0,0.5,1.0,1.4])
mp.xticks([1,6,11])
ax2.set_xlim([0,18])
ax2.set_ylabel(r'$\rho_n(r)$')

ax2.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        labelbottom='off') # labels along the bottom edge are off


mp.savefig("d2.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
fig3 = mp.figure()
#You must select the correct size of the plot in advance
fig3.set_size_inches(3.81,0.58*3.54) 
ax3 = fig3.add_subplot(111)
ax3.text(0.02, 0.95, 'C)', transform=ax3.transAxes, fontsize=12, va='top')
p32 = mp.plot(dens3[:,0], dens3[:,3], color = '0.55', label = r'$\bar{\rho}(r)$')
p30 = mp.plot(dens3[:,0], dens3[:,1], 'r--', label = r'$\rho_0(r)$')
p31 = mp.plot(dens3[:,0], dens3[:,2], 'b:', label = r'$\rho_1(r)$')
ax3.set_ylim([0,1.41])
mp.yticks([0,0.5,1.0,1.4])
ax3.set_ylabel(r'$\rho_n(r)$')
ax3.set_xlim([0,18])
mp.xticks((0.5,3.5,8.5,17),(r'$\underbrace{\hspace{0.35 cm}}_{{\textstyle R_s}}$', r'$\underbrace{\hspace{2 cm}}_{\textstyle l}$', r'$\underbrace{\hspace{2 cm}}_{\textstyle l\cdot g}$', '$r$'))

ax3.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

lns = p30 + p31 + p32
labs = [l.get_label() for l in lns]
ax3.legend(lns, labs, loc='lower right')


mp.savefig("d3.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
