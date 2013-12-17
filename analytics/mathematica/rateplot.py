#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit



avals = range(1,13,1)

def index_map(i):
    k = (i-1)/2.
    return k

mrate = np.zeros((201,4,np.shape(avals)[0]))

for i in avals:
    k = index_map(i)
    target = ''
    target = 'rateplot' + `k` + '.dat'
    load = np.loadtxt(target)
    mrate[:,0:4,i-1] = load



fig2 = mp.figure()
ax2 = fig2.add_subplot(111)

for i in avals:
    k = i-1
    mp.plot(mrate[:,0,k], mrate[:,1,k], label = 'a = ' + `index_map(i)`)
    
fig3 = mp.figure()
ax3 = fig3.add_subplot(111)

for i in avals:
    k = i-1
    mp.plot(mrate[:,0,k], mrate[:,2,k], label = 'a = ' + `index_map(i)`)

    
fig1 = mp.figure()
ax1 = fig1.add_subplot(111)

for i in avals:
    k = i-1
    mp.plot(mrate[:,0,k], mrate[:,3,k], label = 'a = ' + `index_map(i)`)

ax1.legend(loc='upper right')
ax1.set_xlabel('U1')
ax1.set_ylabel('K(U1/2)-(K(U1)+K(U2))/2')
ax1.set_title('Difference between limiting Rates')

ax2.legend(loc='upper right')
ax2.set_xlabel('U1')
ax2.set_ylabel('K(U1/2)')
ax2.set_title('Rate for K01 = K10 -> inf')

ax3.legend(loc='upper right')
ax3.set_xlabel('U1')
ax3.set_ylabel('(K(U1)+K(U0))/2')
ax3.set_title('Rate for K01 = K10 -> 0')

mp.show()
