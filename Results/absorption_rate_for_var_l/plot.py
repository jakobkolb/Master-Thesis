#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

save = 1

statepoints = [[1./0.02,1./0.2,1./2],[1.09836,2.13511,1.79642]]
print statepoints

g_values = [2,5,10]
resolution = 100

asrate_max = [1.2,1.25,1.3]
alrate_max = [1.05,1.09,1.13]

rsrate_max = [1.8,2.3,2.5]
rlrate_max = [1.2,1.3,1.4]

arate = {}
asrate = {}
alrate = {}

rrate = {}
rsrate ={}
rlrate = {}

for l, g in enumerate(g_values):
    arate[`g`]=np.loadtxt("arate"+`g`+".tsv")
    tmp = np.loadtxt("asrate"+`g`+".tsv")
    for i in range(resolution):
        if tmp[i,1]>asrate_max[l]:
            m = i
            break
    asrate[`g`]=tmp[0:m,:]
    tmp = np.loadtxt("alrate"+`g`+".tsv")
    for i in range(resolution):
        i = resolution - i
        if tmp[i,1]>alrate_max[l]:
            m = i
            break
    alrate[`g`]=tmp[m:resolution,:]
    rrate[`g`]=np.loadtxt("rrate"+`g`+".tsv")
    tmp = np.loadtxt("rsrate"+`g`+".tsv")
    for i in range(resolution):
        if tmp[i,1]>rsrate_max[l]:
            m = i
            break
    rsrate[`g`]=tmp[0:m,:]
    tmp = np.loadtxt("rlrate"+`g`+".tsv")
    for i in range(resolution):
        i = resolution - i
        if tmp[i,1]>rlrate_max[l]:
            m = i
            break
    rlrate[`g`]=tmp[m:resolution,:]
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

fig1 = mp.figure()

#You must select the correct size of the plot in advance
#fig.set_size_inches(3.54,2.*3.84)
fig1.set_size_inches(3.54,2.64)

#ax1 = fig.add_subplot(211)
ax1 = fig1.add_subplot(111)
ln1a = mp.plot(arate[`g_values[0]`][:,0],   arate[`g_values[0]`][:,1], color = '0.55', label = 'analytic solution')
ln1b = mp.plot(arate[`g_values[1]`][:,0],   arate[`g_values[1]`][:,1], color = '0.55')
ln1c = mp.plot(arate[`g_values[2]`][:,0],   arate[`g_values[2]`][:,1], color = '0.55')
ln2a = mp.plot(asrate[`g_values[0]`][:,0],  asrate[`g_values[0]`][:,1], 'r--')
ln2b = mp.plot(asrate[`g_values[1]`][:,0],  asrate[`g_values[1]`][:,1], 'r--')
ln2c = mp.plot(asrate[`g_values[2]`][:,0],  asrate[`g_values[2]`][:,1], 'r--')
ln3a = mp.plot(alrate[`g_values[0]`][:,0],  alrate[`g_values[0]`][:,1], 'b-.')
ln3b = mp.plot(alrate[`g_values[1]`][:,0],  alrate[`g_values[1]`][:,1], 'b-.')
ln3c = mp.plot(alrate[`g_values[2]`][:,0],  alrate[`g_values[2]`][:,1], 'b-.')
ax1.text(0.03, 0.95, 'A)', transform=ax1.transAxes, fontsize=12, va='top')
ax1.set_xscale('log')
ax1.set_ylim([0.98,1.32])
ax1.set_xlim([10**(-1.5),10**(4)])
ax1.set_yticks(np.arange(1,1.4,0.1))
ax1.set_ylabel(r'$ K/K_{r_d \rightarrow \infty}$')
ax1.set_xlabel(r'$r_d$')
ax1.annotate('increasing $l$', xy=(10**0.5, 1.05),  xycoords='data',
                xytext=(40, 60), textcoords='offset points',
                arrowprops=dict(arrowstyle="<-")
                )
if save == 1:
    mp.savefig("l_ab_rates.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            pad_inches = 0.1
            )

fig2 = mp.figure()
fig2.set_size_inches(3.54,2.64)

#ax2 = fig.add_subplot(212)
ax2 = fig2.add_subplot(111)
ln1a = mp.plot(rrate[`g_values[0]`][:,0],   rrate[`g_values[0]`][:,1], color = '0.55', label = 'analytic solution')
ln1b = mp.plot(rrate[`g_values[1]`][:,0],   rrate[`g_values[1]`][:,1], color = '0.55')
ln1c = mp.plot(rrate[`g_values[2]`][:,0],   rrate[`g_values[2]`][:,1], color = '0.55')
ln2a = mp.plot(rsrate[`g_values[0]`][:,0],  rsrate[`g_values[0]`][:,1], 'r--')
ln2b = mp.plot(rsrate[`g_values[1]`][:,0],  rsrate[`g_values[1]`][:,1], 'r--')
ln2c = mp.plot(rsrate[`g_values[2]`][:,0],  rsrate[`g_values[2]`][:,1], 'r--')
ln3a = mp.plot(rlrate[`g_values[0]`][:,0],  rlrate[`g_values[0]`][:,1], 'b-.')
ln3b = mp.plot(rlrate[`g_values[1]`][:,0],  rlrate[`g_values[1]`][:,1], 'b-.')
ln3c = mp.plot(rlrate[`g_values[2]`][:,0],  rlrate[`g_values[2]`][:,1], 'b-.')
mp.plot(statepoints[0], statepoints[1], 'kx', label = 'state points')
ax2.text(0.05, 0.91, 'B)', transform=ax1.transAxes, fontsize=12, va='top')
ax2.set_xscale('log')
ax2.set_ylim([0.93,3])
ax2.set_xlim([10**(-1.5),10**(4)])
ax2.legend(loc = 'upper right')
ax2.set_ylabel(r'$ K/K_{r_d \rightarrow \infty}$')
ax2.set_xlabel(r'$r_d$')
ax2.annotate('increasing $l$', xy=(10**0, 1.4),  xycoords='data',
                xytext=(60, 60), textcoords='offset points',
                arrowprops=dict(arrowstyle="<-")
                )


if save==1:
    mp.savefig("l_rb_rates.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            pad_inches = 0.1
            )
elif save==0:
    mp.show()






