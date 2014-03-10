#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

rate = np.loadtxt("rate.tsv")
srate1 = np.loadtxt("srate1.tsv")
srate2 = np.loadtxt("srate2.tsv")
srate3 = np.loadtxt("srate3.tsv")
lrate1 = np.loadtxt("lrate1.tsv")
lrate2 = np.loadtxt("lrate2.tsv")
lrate3 = np.loadtxt("lrate3.tsv")

#Direct input 
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern}"]
#Options
params = {'text.usetex' : True,
          'font.size' : 10,
          'legend.fontsize' : 10,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params) 

fig = mp.figure()

#You must select the correct size of the plot in advance
fig.set_size_inches(3.54,3.84) 

ax1 = fig.add_subplot(111)
ln1a = mp.plot(rate[:,0], rate[:,1], color = '0.55', label = 'analytic solution')
ln1b = mp.plot(rate[:,0], rate[:,2], color = '0.55')
ln1c = mp.plot(rate[:,0], rate[:,3], color = '0.55')
ln2a = mp.plot(srate1[:,0], srate1[:,1], 'r--', label = r' approx. for $r_d \gg 1$' )
ln2b = mp.plot(srate2[:,0], srate2[:,1], 'r--')
ln2c = mp.plot(srate3[:,0], srate3[:,1], 'r--')
ln3a = mp.plot(lrate1[:,0], lrate1[:,1], 'b-.', label = r' approx. for $r_d \ll 1$' )
ln3b = mp.plot(lrate2[:,0], lrate2[:,1], 'b-.')
ln3c = mp.plot(lrate3[:,0], lrate3[:,1], 'b-.')

ax1.annotate('increasing t', xy=(10**0, 0.7),  xycoords='data',
                xytext=(60, 60), textcoords='offset points',
                arrowprops=dict(arrowstyle="<-")
                )

#ax1.annotate('increasing t', xy=(10**0.5, 1.15),  xycoords='data',
#                xytext=(40, 60), textcoords='offset points',
#                arrowprops=dict(arrowstyle="<-")
#                )


ax1.set_xscale('log')
ax1.set_ylim([0.4,1.6])
#ax1.set_ylim([1,1.5])
ax1.legend(loc = 'upper right')
ax1.set_ylabel(r'$ K/K_{Debye}$')
ax1.set_xlabel(r'$r_d$')

mp.savefig("density_profiles.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            )







