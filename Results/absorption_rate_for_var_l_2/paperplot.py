#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

reds =  ['#660000', '#CC0000', '#FF3333', '#FF9999', '#FF9999']
blues = ['#004C99', '#0080FF', '#66B2FF', '#CCE5FF', '#CCE5FF']

statepoints = np.zeros((2,3))
statepoints[0,:] = [251.188643150958,2.51188643150958,0.251188643150958]
statepoints[1,:] = [0.7049618891559459,1.0403535894103817,0.9129754243089283]

bd_measure = np.zeros((3,3))
bd_measure[0,:] = [250,2.5,0.25]
bd_measure[1,:] = [7.24730482e-01,1.05827586e+00,9.02457930e-01]
bd_measure[2,:] = [3.18952981e-02,4.04150783e-02,3.54952254e-02]

D = 0.025

print 'switching rates'
for i in range(3):
    print i, bd_measure[0,i]
    print D/(2*statepoints[0,i]**2)

print statepoints

save = 1

g_values = [2,5,10]
resolution = 100

asrate_max = [1.25,1.25,1.27]
alrate_max = [1.15,1.13,1.1]

rsrate_max = [0.97,1.1,1.2]
rlrate_max = [0.8,1,1.1]

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
height = 0.9
fig1 = mp.figure()

#You must select the correct size of the plot in advance
#fig.set_size_inches(3.54,2.*3.84)
fig1.set_size_inches(3.54,height*3.54)

#ax1 = fig.add_subplot(211)
ax1 = fig1.add_subplot(111)
ln1a = mp.plot(arate[`g_values[0]`][:,0],   arate[`g_values[0]`][:,1], color = reds[3], label = 'analytic solution')
ln1b = mp.plot(arate[`g_values[1]`][:,0],   arate[`g_values[1]`][:,1], color = reds[2])
ln1c = mp.plot(arate[`g_values[2]`][:,0],   arate[`g_values[2]`][:,1], color = reds[1])
ln2a = mp.plot(asrate[`g_values[0]`][:,0],  asrate[`g_values[0]`][:,1], 'k--', alpha = .2)
ln2b = mp.plot(asrate[`g_values[1]`][:,0],  asrate[`g_values[1]`][:,1], 'k--', alpha = .6)
ln2c = mp.plot(asrate[`g_values[2]`][:,0],  asrate[`g_values[2]`][:,1], 'k--', alpha = 1 )
ln3a = mp.plot(alrate[`g_values[0]`][:,0],  alrate[`g_values[0]`][:,1], 'k.' , alpha = .2, ms = 2.5)
ln3b = mp.plot(alrate[`g_values[1]`][:,0],  alrate[`g_values[1]`][:,1], 'k.' , alpha = .6, ms = 2.5)
ln3c = mp.plot(alrate[`g_values[2]`][:,0],  alrate[`g_values[2]`][:,1], 'k.' , alpha = 1 , ms = 2.5)
ax1.text(0.05, 0.95, 'B)', transform=ax1.transAxes, fontsize=12, va='top')
ax1.set_xscale('log')
ax1.set_ylim([1,1.3])
ax1.set_yticks(np.arange(1,1.31,0.1))
ax1.set_ylabel(r'$ k/k_{S}$')
ax1.set_xlabel(r'$r_d$')
ax1.annotate('increasing $l$', xy=(10**0.5, 1.1),  xycoords='data',
                xytext=(40, 40), textcoords='offset points',
                arrowprops=dict(arrowstyle="<-")
                )
if save == 1:
    mp.savefig("l2_ab_rates.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )



fig2 = mp.figure()
fig2.set_size_inches(3.54,height*3.54)

#ax2 = fig.add_subplot(212)
ax2 = fig2.add_subplot(111)
ln1a = mp.plot(rrate[`g_values[0]`][:,0],   rrate[`g_values[0]`][:,1], color = blues[3], zorder = 0, label = 'analytic \nsolution')
ln1b = mp.plot(rrate[`g_values[1]`][:,0],   rrate[`g_values[1]`][:,1], color = blues[2], zorder = 0)
ln1c = mp.plot(rrate[`g_values[2]`][:,0],   rrate[`g_values[2]`][:,1], color = blues[1], zorder = 0)
ln2a = mp.plot(rsrate[`g_values[0]`][:,0], rsrate[`g_values[0]`][:,1], 'k--',alpha = .2, zorder = 1)
ln2b = mp.plot(rsrate[`g_values[1]`][:,0], rsrate[`g_values[1]`][:,1], 'k--',alpha = .6, zorder = 1)
ln2c = mp.plot(rsrate[`g_values[2]`][:,0], rsrate[`g_values[2]`][:,1], 'k--',alpha = 1 , zorder = 1)
ln3a = mp.plot(rlrate[`g_values[0]`][:,0], rlrate[`g_values[0]`][:,1], 'k.' ,alpha = .2, ms = 2.5, zorder = 1)
ln3b = mp.plot(rlrate[`g_values[1]`][:,0], rlrate[`g_values[1]`][:,1], 'k.' ,alpha = .6, ms = 2.5, zorder = 1)
ln3c = mp.plot(rlrate[`g_values[2]`][:,0], rlrate[`g_values[2]`][:,1], 'k.' ,alpha = 1 , ms = 2.5, zorder = 1)
mp.plot(statepoints[0], statepoints[1], 'kx' ,ms=9, mew=1.2 , label = 'state \npoints', zorder = 3)
mp.errorbar(bd_measure[0], bd_measure[1] ,yerr = bd_measure[2], linestyle = 'none', marker = 'o', mfc = reds[3], mec = reds[1],  color = reds[2], label = 'BD', zorder=2)
ax2.text(0.05, 0.95, 'A)', transform=ax2.transAxes, fontsize=12, va='top')
ax2.set_xscale('log')
ax2.set_ylim([0.55,1.2])
ax2.legend(loc = 'lower left')
ax2.set_ylabel(r'$ k/k_{S}$')
ax2.set_xlabel(r'$r_d$')
ax2.annotate('increasing $l$', xy=(10**0, 0.8),  xycoords='data',
                xytext=(60, 60), textcoords='offset points',
                arrowprops=dict(arrowstyle="<-")
                )


if save==1:
    mp.savefig("l2_rb_rates.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )
elif save==0:
    mp.show()





