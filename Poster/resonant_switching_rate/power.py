#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
import math
from scipy.optimize import curve_fit
import sympy
kt = 1.
d = 1.

def calc_rate(u,rd,g,t,kt,d):


    x = sympy.Symbol('x')
    a = sympy.Symbol('a')
    b = sympy.Symbol('b')

    k=(-sympy.exp(4*a*x)+sympy.exp(2*(1+a)*x)-sympy.exp(2*(1+b)*x)+sympy.exp(2*(a+b)*x)+a*sympy.exp(4*a*x)*x-b*sympy.exp(4*a*x)*x-a*sympy.exp(2*(1+a)*x)*x+b*sympy.exp(2*(1+a)*x)*x-a*sympy.exp(2*(1+b)*x)*x+3*b*sympy.exp(2*(1+b)*x)*x+a*sympy.exp(2*(a+b)*x)*x-3*b*sympy.exp(2*(a+b)*x)*x-2*b*sympy.exp((2+a+b)*x)*x+2*b*sympy.exp((3*a+b)*x)*x+a*b*sympy.exp(4*a*x)*x*x-a*b*sympy.exp(2*(1+a)*x)*x*x+3*a*b*sympy.exp(2*(1+b)*x)*x*x-3*a*b*sympy.exp(2*(a+b)*x)*x*x-2*b*b*sympy.exp((2+a+b)*x)*x*x+2*b*b*sympy.exp((3*a+b)*x)*x*x)/(-sympy.exp(4*a*x)+sympy.exp(2*(1+a)*x)-sympy.exp(2*(1+b)*x)+sympy.exp(2*(a+b)*x)+a*sympy.exp(4*a*x)*x-b*sympy.exp(4*a*x)*x+2*sympy.exp(2*(1+a)*x)*x-3*a*sympy.exp(2*(1+a)*x)*x+b*sympy.exp(2*(1+a)*x)*x+2*sympy.exp(2*(1+b)*x)*x-a*sympy.exp(2*(1+b)*x)*x+b*sympy.exp(2*(1+b)*x)*x-4*sympy.exp(2*(a+b)*x)*x+3*a*sympy.exp(2*(a+b)*x)*x-b*sympy.exp(2*(a+b)*x)*x-4*sympy.exp((2+a+b)*x)*x+2*a*sympy.exp((2+a+b)*x)*x+4*sympy.exp((3*a+b)*x)*x-2*a*sympy.exp((3*a+b)*x)*x+a*b*sympy.exp(4*a*x)*x*x+2*b*sympy.exp(2*(1+a)*x)*x*x-3*a*b*sympy.exp(2*(1+a)*x)*x*x+2*a*sympy.exp(2*(1+b)*x)*x*x+a*b*sympy.exp(2*(1+b)*x)*x*x-2*a*sympy.exp(2*(a+b)*x)*x*x+2*b*sympy.exp(2*(a+b)*x)*x*x-3*a*b*sympy.exp(2*(a+b)*x)*x*x-2*a*sympy.exp((2+a+b)*x)*x*x+2*a*a*sympy.exp((2+a+b)*x)*x*x-2*b*sympy.exp((2+a+b)*x)*x*x-2*a*sympy.exp((3*a+b)*x)*x*x+2*a*a*sympy.exp((3*a+b)*x)*x*x+2*b*sympy.exp((3*a+b)*x)*x*x)

#    x = np.sqrt(2*rate/d)**(-1)
#    a = spacing[1]
#    b = spacing[2]

    tmp = k.subs(x,1./rd).subs(a,1+t).subs(b,1+(1+g)*t)
    out = tmp.evalf()
    return out


def powerlaw(x,a,b):
    return a*x**b

u = 10.

rdvalues = 10**np.arange(-4,4,0.01)
tvalues = 10**np.arange(-3,4,0.1)
print tvalues
#gvalues = np.arange(1,4,0.1)
#gvalues = [1,2,3]
gvalues = [1]
arates = np.zeros((np.shape(rdvalues)[0],2))
kmax = np.zeros((np.shape(tvalues)[0],np.shape(gvalues)[0],4))
fit_parameters = np.zeros((np.shape(gvalues)[0],3))

g_index = -1
istop = 10
istart = 0

for g in gvalues:
    g_index = g_index + 1
    t_index = -1
    for t in tvalues:
        t_index = t_index + 1
        for i in range(istart,istop,1):
            rate = calc_rate(u,rdvalues[i],g,t,kt,d)
            if math.isnan(rate):
                break
            arates[i,1] = rate
            arates[i,0] = rdvalues[i]
        indices = np.argmax(arates[:,1])
        kmax[t_index,g_index,:] = [t, g, arates[indices,0], arates[indices,1]]
        istop = indices + 30
        istart = max(0,indices-10)
        print t, istart, istop
    popt, cov = curve_fit(powerlaw, kmax[:,g_index,2], kmax[:,g_index,0])
    print cov, popt, g, t
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


fig2 = mp.figure()
ax2 = fig2.add_subplot(111)
for i in range(np.shape(gvalues)[0]):
    mp.plot(kmax[:,i,0], kmax[:,i,3], color = '#666666')

ax2.set_xscale('log')
ax2.set_xlabel('$l$')
ax2.set_ylabel('$K^{(res)}$')

ax1 = mp.axes([0.5,0.22,.37,.3])
for i in range(np.shape(gvalues)[0]):
    mp.plot(kmax[:,i,0], kmax[:,i,2], label=('g = %1.1f' %kmax[1,i,1]), color = '#aa0000')

ax1.set_xlabel(r'$l$')
ax1.set_ylabel(r'$r_d^{(res)}$')
ax1.set_yscale('log')
ax1.set_xscale('log')
ax1.set_xticks([0.01, 1, 100])
ax1.set_yticks([0.0001,0.01,1,100])
ax1.get_xaxis().get_major_formatter().labelOnlyBase = False
ax1.get_yaxis().get_major_formatter().labelOnlyBase = False
#You must select the correct size of the plot in advance
fig2.set_size_inches(3.54,3.54)


mp.savefig("powerlaw.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )


mp.show()
