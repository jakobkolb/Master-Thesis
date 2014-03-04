#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

rate = np.loadtxt("rate.tsv")
srate = np.loadtxt("srate.tsv")
lrate = np.loadtxt("lrate.tsv")


fig = mp.figure()
ax1 = fig.add_subplot(111)
ln1 = mp.plot(rate[:,0], rate[:,1], label = 'analytic solution')
ln2 = mp.plot(srate[:,0], srate[:,1], '--', label = r' approx. for $r_d \gg 1$' )
ln3 = mp.plot(lrate[:,0], lrate[:,1], '-.', label = r' approx. for $r_d \ll 1$' )
ax1.set_title('absorption vs. decay length for repulsive potential barrier')
ax1.set_xscale('log')
ax1.legend(loc = 'upper right')
ax1.set_ylabel(r'$ \frac{K}{K_{Debye}}$', fontsize = 16)
ax1.set_xlabel(r'$r_d$', fontsize = 16)

mp.show()






















