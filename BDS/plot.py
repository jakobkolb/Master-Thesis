#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit

list_of_Rs = range(1,2,1)

nbins = 1000
pi = 3.14159265359

def index_map(i):
    k = i-1
    return k

#____________________________________#
#Import measured rate data from file #

print 'read data from files '

mrate = np.zeros((np.shape(list_of_Rs)[0],14))
for i in list_of_Rs:
        target = ''
        target =  'rate_data.out'
        load = np.loadtxt(target, skiprows=2)
        k = index_map(i)
        mrate[k,0:14] = load
print np.shape(mrate)
print mrate

#____________________________________#
#Import measured dens data from file #

print 'read density data from files'

densdata = np.zeros((1000,7,np.shape(list_of_Rs)[0]))
k = 0
for i in list_of_Rs:
    target = ''
    target =  'dens_data.out'
    k = index_map(i)
    densdata[:,0:7,k] = np.loadtxt(target)

#print densdata

for k in list_of_Rs:
    j = index_map(k)
    particles = 0
    r = 0
    dr = densdata[1,0,j] - densdata[0,0,j]
    for i in range(0,np.shape(densdata)[0]):
        voli = 4./3.*np.pi*((r+dr)**3-r**3)
        r = r + dr
        particles = particles + densdata[i,1,j]+densdata[i,3,j]
        densdata[i,1:5,j] =  densdata[i,1:5,j]/voli
    print particles
def rho_1(r, Rs, Ua, Ub, U0, KT):
    alpha1 = 1
    alpha2 = (1-Rs/(Rs+Ua))*np.exp(-U0/KT) + Rs/(Rs + Ua)
    alpha3 = Rs*(np.exp(U0/KT) - 1)*(1/(Rs+Ua) - 1/(Rs+Ua+Ub)) + 1
    rho = np.zeros((np.shape(r)[0]))
    for k in range(0,np.shape(r)[0]):
        if r[k] < Rs:
            rho[k] = 0
        elif r[k] >= Rs and r[k] < Rs + Ua:
            rho[k] = alpha1-Rs/r[k]
        elif r[k] >= Rs + Ua and r[k] < Rs + Ua + Ub:
            rho[k] = alpha2-Rs/r[k]
        elif r[k] >= Rs + Ua + Ub:
            rho[k] = alpha3-Rs/r[k]
        else :
            print 'error'

    return rho

def I(alpha, Rs, b, a):
    I = (alpha/3.*a**3 - Rs/2.*a**2 - alpha/3.*b**3 + Rs/2.*b**2)
    return I

def rho_0(N,D,KT,Rs,Rd,U0,Ua,Ub):
    alpha1 = 1
    alpha2 = (1-Rs/(Rs+Ua))*np.exp(-U0/KT) + Rs/(Rs + Ua)
    alpha3 = Rs*(np.exp(U0/KT) - 1)*(1/(Rs+Ua) - 1/(Rs+Ua+Ub)) + 1
    rho_0 = N/4./np.pi/(I(alpha1,Rs,Rs,Rs+Ua) + I(alpha2,Rs,Rs+Ua,Rs+Ua+Ub) + I(alpha3,Rs, Rs+Ua+Ub,Rd))
    return rho_0

#____________________________________#
#use different plots to show results #

fig = mp.figure()
ax = fig.add_subplot(111)
pltlist = [1]

for k in pltlist:

    i = index_map(k)

    print rho_0(mrate[i,0], mrate[i,1], 1, mrate[i,2], mrate[i,3], mrate[i,6], mrate[i,7], mrate[i,8])

    lns1 = mp.plot( densdata[:,0,i]/mrate[i,2], densdata[:,1,i], label='rho_0')
    print i
#    mp.plot( densdata[:,0,i], densdata[:,3,i])
    mp.fill_between(densdata[:,0,i]/mrate[i,2],densdata[:,1,i]-densdata[:,2,i],densdata[:,1,i]+densdata[:,2,i],color='grey', alpha=0.3)
    lns2 = mp.plot( densdata[:,0,i]/mrate[i,2], densdata[:,3,i], label='rho_1')

ax2 = ax.twinx()
#for k in pltlist:

#    lns3 = mp.plot( densdata[:,0,i], densdata[:,4,i], label = 'Potential Barrier')

lns = lns1 + lns2# + lns3
labs = [l.get_label() for l in lns]
ax.legend(lns, labs, loc='upper left')


ax.set_xlabel('r/Rs')
ax.set_ylabel('rho/rho_0')
ax2.set_ylabel('U(r/Rs)')

mp.show(2)



