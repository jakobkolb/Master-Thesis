#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
#import scipy.optimize as so

a = np.loadtxt('dens_data.out')

D = 0.1
Rs= 1.
Rd= 10.
N = 1.5E3

def Normalization_Constant(a, upper_bound, lower_bound):
    Normalization_Constant = 4.*np.pi*(1/3.*upper_bound**3 - a/2.*upper_bound**2 - 1/3.*lower_bound**3 + a/2.*lower_bound**2)
    return Normalization_Constant

def rho(r,C):
    rho = N/C*(1-Rs/r)
    return rho

print np.shape(a)[0]
particles = 0
threequarterstimespi = 4./3.*np.pi
dr = a[1,0] - a[0,0]
r = 0
for i in range(0,np.shape(a)[0]):
    voli = threequarterstimespi*((r+dr)**3-r**3)
    r = r + dr
    particles = particles + a[i,1]
    a[i,1:3] =  a[i,1:3]/voli

print particles

def K(R,a,D,N):
    C = Normalization_Constant(a,R,a)
    K = 4.*np.pi*a*D*N/C
    return K

b = np.loadtxt('rate_data.out', skiprows=2)

print b[3], 'pm', b[4], K(Rd,Rs,D,N),(1-b[3]/K(Rd,Rs,D,N))*100, (b[4]/b[3]*100)

mp.close()
C = Normalization_Constant(Rs, Rd, Rs)
mp.figure(1)
mp.plot(a[:,0], a[:,1])
mp.fill_between(a[:,0],a[:,1]-a[:,2],a[:,1]+a[:,2],color='grey',alpha=0.3)
mp.plot(a[100:999,0], rho(a[100:999,0],C), 'r-')
mp.show()



