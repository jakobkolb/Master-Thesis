#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
import math
from scipy.optimize import curve_fit
import sympy
import pickle

kt = 1.
d = 1.
u = 3.

def calc_rate(u,rd,g,t,kt,d):

    x = sympy.Symbol('x')
    a = sympy.Symbol('a')
    b = sympy.Symbol('b')
   
    k=(-2*sympy.exp(u+2*(1+b)*x)*(1+a*x)*(-1+b*x)-2*b*sympy.exp((2+a+b)*x)*x*(1+b*x)+2*b*sympy.exp((3*a+b)*x)*x*(1+b*x)
            -4*b*sympy.exp(u+3*a*x+b*x)*x*(1+b*x)+2*b*sympy.exp(2*u+3*a*x+b*x)*x*(1+b*x)
            +4*b*sympy.exp(u+(2+a+b)*x)*x*(1+b*x)-2*b*sympy.exp(2*u+(2+a+b)*x)*x*(1+b*x)
            +sympy.exp(4*a*x)*(-1+a*x)*(1+b*x)-sympy.exp(2*(1+a)*x)*(-1+a*x)*(1+b*x)
            -2*sympy.exp(u+4*a*x)*(-1+a*x)*(1+b*x)+sympy.exp(2*u+4*a*x)*(-1+a*x)*(1+b*x)
            -2*sympy.exp(u+2*(1+a)*x)*(1+a*x)*(1+b*x)-sympy.exp(2*(u+x+b*x))*(1+a*x)*(1+b*x)
            -sympy.exp(2*(u+(a+b)*x))*(-1+3*a*x)*(1+b*x)+sympy.exp(2*(u+x+a*x))*(1+3*a*x)*(1+b*x)
            +sympy.exp(2*(1+b)*x)*(1+a*x)*(-1+3*b*x)-sympy.exp(2*(a+b)*x)*(1+a*x)*(-1+3*b*x)
            +2*sympy.exp(u+2*(a+b)*x)*(-1+b*x+a*(x-5*b*x*x)))/(2*sympy.exp(u+2*(1+b)*x)*(1+a*x)*(1+(-2+b)*x)
            +2*sympy.exp((2+a+b)*x)*x*(-2+a-a*x+a*a*x-b*x)-4*sympy.exp(u+(2+a+b)*x)*x*(-2+a-a*x+a*a*x-b*x)
            +2*sympy.exp(2*u+(2+a+b)*x)*x*(-2+a-a*x+a*a*x-b*x)+2*sympy.exp(u+2*(1+a)*x)*(-1+(-2+a)*x)*(1+b*x)
            +sympy.exp(4*a*x)*(-1+a*x)*(1+b*x)-2*sympy.exp(u+4*a*x)*(-1+a*x)*(1+b*x)
            +sympy.exp(2*u+4*a*x)*(-1+a*x)*(1+b*x)+sympy.exp(2*(u+x+a*x))*(1+(2+a)*x)*(1+b*x)
            -sympy.exp(2*(1+a)*x)*(-1+(-2+3*a)*x)*(1+b*x)+sympy.exp(2*(1+b)*x)*(1+a*x)*(-1+(2+b)*x)
            -sympy.exp(2*(u+x+b*x))*(1+a*x)*(1+(-2+3*b)*x)-sympy.exp(2*(u+(a+b)*x))*(-1+(4+a-3*b)*x+3*(a*(-2+b)+2*b)*x*x)
            -sympy.exp(2*(a+b)*x)*(-1+(4-3*a+b)*x+(-2*b+a*(2+3*b))*x*x)
            -2*sympy.exp(u+2*(a+b)*x)*(1+(-4+a+b)*x+(-2*b+a*(2+5*b))*x*x)
            +2*sympy.exp((3*a+b)*x)*x*(2+a*a*x+b*x-a*(1+x))-4*sympy.exp(u+3*a*x+b*x)*x*(2+a*a*x+b*x-a*(1+x))
            +2*sympy.exp(2*u+3*a*x+b*x)*x*(2+a*a*x+b*x-a*(1+x)))

#    x = np.sqrt(2*rate/d)**(-1)
#    a = spacing[1]
#    b = spacing[2]

    tmp = k.subs(x,1./rd).subs(a,1+t).subs(b,1+(1+g)*t)
    out = tmp.evalf()
    return out


def powerlaw(x,a,b):
    return a*x**b


rdvalues = 10**np.arange(-4,5,0.01)
tvalues = 10**np.arange(-2,2,1)
gvalues = 10**np.arange(-2,2,1)
print gvalues
#gvalues = [1]
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
        arates[:,:] = 0.
        for i in range(istart,istop,1):
            rate = calc_rate(u,rdvalues[i],g,t,kt,d)
            if math.isnan(rate):
                break
            arates[i,1] = rate
            arates[i,0] = rdvalues[i]
        indices = np.argmax(arates[:,1])
        kmax[t_index,g_index,:] = [t, g, arates[indices,0], arates[indices,1]]
        istop = min(indices + 50,np.shape(rdvalues)[0])
        istart = max(0,indices-50)

with open('resonance_data.p', 'w') as fo:
    pickle.dump(kmax,fo)


