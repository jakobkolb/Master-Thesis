#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
import math
from scipy.optimize import curve_fit

kt = 1.
d = 1.
def rho(r,eig,d):
    rho = np.array([[1.,1./r,0,0],[0,0,np.exp(-np.sqrt(abs(eig[1])/d)*r)/r,np.exp(np.sqrt(abs(eig[1])/d)*r)/r]])
    return rho

def rhodash(r,eig,d):
    rhodash = np.array([[0,-1./r**2,0,0],[0,0, -np.sqrt(abs(eig[1])/d)*np.exp(-np.sqrt(abs(eig[1])/d)*r)/r-np.exp(-np.sqrt(abs(eig[1])/d)*r)/r**2, np.sqrt(abs(eig[1])/d)*np.exp(np.sqrt(abs(eig[1])/d)*r)/r-np.exp(np.sqrt(abs(eig[1])/d)*r)/r**2]])
    return rhodash

def calc_rate(u,rate,spacing,kt,d):


    x = np.sqrt(2*rate/d)
    a = spacing[1]
    b = spacing[2]
    w = np.array([[-rate,rate],[rate,-rate]])

    (eig,s) = np.linalg.eig(w)
    s[0:2,0] = s[0:2,0]/np.linalg.norm(s[0:2,0])
    s[0:2,1] = s[0:2,1]/np.linalg.norm(s[0:2,1])

    invs = np.linalg.inv(s)

    k=(-np.exp(4*a*x)+np.exp(2*(1+a)*x)-np.exp(2*(1+b)*x)+np.exp(2*(a+b)*x)+a*np.exp(4*a*x)*x-b*np.exp(4*a*x)*x-a*np.exp(2*(1+a)*x)*x+b*np.exp(2*(1+a)*x)*x-a*np.exp(2*(1+b)*x)*x+3*b*np.exp(2*(1+b)*x)*x+a*np.exp(2*(a+b)*x)*x-3*b*np.exp(2*(a+b)*x)*x-2*b*np.exp((2+a+b)*x)*x+2*b*np.exp((3*a+b)*x)*x+a*b*np.exp(4*a*x)*x*x-a*b*np.exp(2*(1+a)*x)*x*x+3*a*b*np.exp(2*(1+b)*x)*x*x-3*a*b*np.exp(2*(a+b)*x)*x*x-2*b*b*np.exp((2+a+b)*x)*x*x+2*b*b*np.exp((3*a+b)*x)*x*x)/(-np.exp(4*a*x)+np.exp(2*(1+a)*x)-np.exp(2*(1+b)*x)+np.exp(2*(a+b)*x)+a*np.exp(4*a*x)*x-b*np.exp(4*a*x)*x+2*np.exp(2*(1+a)*x)*x-3*a*np.exp(2*(1+a)*x)*x+b*np.exp(2*(1+a)*x)*x+2*np.exp(2*(1+b)*x)*x-a*np.exp(2*(1+b)*x)*x+b*np.exp(2*(1+b)*x)*x-4*np.exp(2*(a+b)*x)*x+3*a*np.exp(2*(a+b)*x)*x-b*np.exp(2*(a+b)*x)*x-4*np.exp((2+a+b)*x)*x+2*a*np.exp((2+a+b)*x)*x+4*np.exp((3*a+b)*x)*x-2*a*np.exp((3*a+b)*x)*x+a*b*np.exp(4*a*x)*x*x+2*b*np.exp(2*(1+a)*x)*x*x-3*a*b*np.exp(2*(1+a)*x)*x*x+2*a*np.exp(2*(1+b)*x)*x*x+a*b*np.exp(2*(1+b)*x)*x*x-2*a*np.exp(2*(a+b)*x)*x*x+2*b*np.exp(2*(a+b)*x)*x*x-3*a*b*np.exp(2*(a+b)*x)*x*x-2*a*np.exp((2+a+b)*x)*x*x+2*a*a*np.exp((2+a+b)*x)*x*x-2*b*np.exp((2+a+b)*x)*x*x-2*a*np.exp((3*a+b)*x)*x*x+2*a*a*np.exp((3*a+b)*x)*x*x+2*b*np.exp((3*a+b)*x)*x*x)

    return k

def powerlaw(x,a,b):
    return a*x**b

u = 10.

srates = 10**np.arange(-1,6,0.001)
tvalues = 10**np.arange(-1,100,1)
#gvalues = np.arange(1,4,0.1)
#gvalues = [1,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.81,1.9,2.,2.11,2.2,2.31,2.4,2.5,2.6,2.7,2.8,2.9,3.]
#gvalues = [1,2,3]
gvalues = [1]
arates = np.zeros((np.shape(srates)[0],2))
kmax = np.zeros((np.shape(tvalues)[0],np.shape(gvalues)[0],4))
fit_parameters = np.zeros((np.shape(gvalues)[0],3))

g_index = -1

for g in gvalues:
    g_index = g_index + 1
    t_index = -1
    for t in tvalues:
        t_index = t_index + 1
        spacing = np.array([1.,1.+t,1.+(1.+g)*t])
        istop = np.shape(srates)[0]
        for i in range(0,istop,1):
            rate = calc_rate(u,srates[i],spacing,kt,d)
            if math.isnan(rate):
                break
            arates[i,1] = rate
            arates[i,0] = 1./srates[i]
        indices = np.argmax(arates[:,1])
        if  math.isnan(arates[indices,1]):
            print 'there still are fuckin nans'
        kmax[t_index,g_index,:] = [t, g, arates[indices,0], arates[indices,1]]
        istop = indices + 100
    popt, cov = curve_fit(powerlaw, kmax[:,g_index,2], kmax[:,g_index,0])
    print cov, g
    fit_parameters[g_index,:] = g, popt[0], popt[1]

#Direct input
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern}"]
#Options
params = {'text.usetex' : True,
          'font.size' : 11,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params)
fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
for i in range(np.shape(gvalues)[0]):
    mp.plot(kmax[:,i,0], kmax[:,i,2], label=('g = %1.1f' %kmax[1,i,1]))

mp.legend(loc='upper left')
ax1.set_xlabel('t')
ax1.set_ylabel(r'r_d^{(res)}')
ax1.set_yscale('log')
ax1.set_xscale('log')
ax1.set_xlim(0.1,1.1)

#You must select the correct size of the plot in advance
fig1.set_size_inches(3.54,3.54)


mp.savefig("resonant_decay_length.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )


fig3 = mp.figure()
ax31 = fig3.add_subplot(211)
ax31.set_xlabel(r'$g$')
ax31.set_ylabel(r'$C(g)$')
mp.plot(fit_parameters[:,0], fit_parameters[:,1])

ax32 = fig3.add_subplot(212)
ax32.set_ylabel(r'$\kappa (g)$')
ax32.set_xlabel(r'$g$')
mp.plot(fit_parameters[:,0], fit_parameters[:,2])

#You must select the correct size of the plot in advance
fig3.set_size_inches(3.54,4.54)


mp.savefig("powerlaw_parameters.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )


