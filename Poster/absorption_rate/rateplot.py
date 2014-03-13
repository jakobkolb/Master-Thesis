#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

arate2  = np.loadtxt("arate2.tsv")
arate4  = np.loadtxt("arate5.tsv")
arate10  = np.loadtxt("arate10.tsv")
asrate2 = np.loadtxt("asrate2.tsv")
asrate4 = np.loadtxt("asrate5.tsv")
asrate10 = np.loadtxt("asrate10.tsv")
alrate2 = np.loadtxt("alrate2.tsv")
alrate4 = np.loadtxt("alrate5.tsv")
alrate10 = np.loadtxt("alrate10.tsv")

rrate2  = np.loadtxt("rrate2.tsv")
rrate4  = np.loadtxt("rrate5.tsv")
rrate10  = np.loadtxt("rrate10.tsv")
rsrate2 = np.loadtxt("rsrate2.tsv")
rsrate4 = np.loadtxt("rsrate5.tsv")
rsrate10 = np.loadtxt("rsrate10.tsv")
rlrate2 = np.loadtxt("rlrate2.tsv")
rlrate4 = np.loadtxt("rlrate5.tsv")
rlrate10 = np.loadtxt("rlrate10.tsv")

statepoints = [[1./0.04,1./0.4,1./4],[1.09836,2.13511,1.79642]]
print statepoints

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
#fig.set_size_inches(3.54,2.*3.84)
fig.set_size_inches(2.*3.54,3.04)

#ax1 = fig.add_subplot(211)
ax1 = fig.add_subplot(121)
ln1a = mp.plot(arate2[:,0],     arate2[:,1], color = '0.55', label = 'analytic solution')
ln1b = mp.plot(arate4[:,0],     arate4[:,1], color = '0.55')
ln1c = mp.plot(arate10[:,0],    arate10[:,1], color = '0.55')
ln2a = mp.plot(asrate2[:,0],    asrate2[:,1], 'r--', label = r' approx. for $r_d \gg 1$' )
ln2b = mp.plot(asrate4[:,0],    asrate4[:,1], 'r--')
ln2c = mp.plot(asrate10[:,0],   asrate10[:,1], 'r--')
ln3a = mp.plot(alrate2[:,0],    alrate2[:,1], 'b-.', label = r' approx. for $r_d \ll 1$' )
ln3b = mp.plot(alrate4[:,0],    alrate4[:,1], 'b-.')
ln3c = mp.plot(alrate10[:,0],   alrate10[:,1], 'b-.')
ax1.set_xscale('log')
ax1.set_ylim([0.98,1.4])
ax1.set_yticks(np.arange(1.,1.5,0.1))
ax1.set_ylabel(r'$ K/K_{Debye}$')
ax1.set_xlabel(r'$r_d$')
ax1.annotate('increasing t', xy=(10**0.5, 1.05),  xycoords='data',
                xytext=(40, 60), textcoords='offset points',
                arrowprops=dict(arrowstyle="<-")
                )


#ax2 = fig.add_subplot(212)
ax2 = fig.add_subplot(122)
mp.plot(statepoints[0], statepoints[1], 'kx', label = 'state points')
ln1a = mp.plot(rrate2[:,0],     rrate2[:,1], color = '0.55', label = 'analytic solution')
ln1b = mp.plot(rrate4[:,0],     rrate4[:,1], color = '0.55')
ln1c = mp.plot(rrate10[:,0],    rrate10[:,1], color = '0.55')
ln2a = mp.plot(rsrate2[:,0],    rsrate2[:,1], 'r--', label = r' approx. for $r_d \gg 1$' )
ln2b = mp.plot(rsrate4[:,0],    rsrate4[:,1], 'r--')
ln2c = mp.plot(rsrate10[:,0],   rsrate10[:,1], 'r--')
ln3a = mp.plot(rlrate2[:,0],    rlrate2[:,1], 'b-.', label = r' approx. for $r_d \ll 1$' )
ln3b = mp.plot(rlrate4[:,0],    rlrate4[:,1], 'b-.')
ln3c = mp.plot(rlrate10[:,0],   rlrate10[:,1], 'b-.')
ax2.set_xscale('log')
ax2.set_ylim([0.9,3.5])
ax2.legend(loc = 'upper right')
ax2.set_ylabel(r'$ K/K_{Debye}$')
ax2.set_xlabel(r'$r_d$')
ax2.annotate('increasing t', xy=(10**0, 1.4),  xycoords='data',
                xytext=(60, 60), textcoords='offset points',
                arrowprops=dict(arrowstyle="<-")
                )



mp.savefig("density_profiles.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )







