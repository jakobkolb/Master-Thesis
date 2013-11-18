#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
#import scipy.optimize as so

x = np.loadtxt('dens_data.out')

D = 0.1
Rs= 1.
Rd= 10.
N = 1.5E3
U0 = 1
Ua = 4
Ub = 1
Un = 8

def Normalization_Constant(a, upper_bound, lower_bound):
    Normalization_Constant = 4.*np.pi*(1/3.*upper_bound**3 - a/2.*upper_bound**2 - 1/3.*lower_bound**3 + a/2.*lower_bound**2)
    return Normalization_Constant

def rho(r,C):
    rho = N/C*(1-Rs/r)
    return rho

print np.shape(x)[0]
particles = 0
threequarterstimespi = 4./3.*np.pi
dr = x[1,0] - x[0,0]
r = 0
for i in range(0,np.shape(x)[0]):
    voli = threequarterstimespi*((r+dr)**3-r**3)
    r = r + dr
    particles = particles + x[i,1]
    x[i,1:3] =  x[i,1:3]/voli

def U(Rr, U0, a, b):
    U =  U0/((2./b*(Rr-a))**(2.*Un) + 1.)
    return U

def gradU(Rr, U0, a, b):
    gradU =  4.*Un*U0*((2./b*(Rr-a))**(2.*Un-1.))/b/((2./b*(Rr-a))**(2.*Un) + 1.)**2
    return gradU

print particles

def K(R,a,D,N):
    C = Normalization_Constant(a,R,a)
    K = 4.*np.pi*a*D*N/C
    return K

b = np.loadtxt('rate_data.out', skiprows=2)

print b[3], 'pm', b[4], K(Rd,Rs,D,N),(1-b[3]/K(Rd,Rs,D,N))*100, (b[4]/b[3]*100)

a = Rs + Ua + 0.5*Ub
b = Ub

mp.close()
C = Normalization_Constant(Rs, Rd, Rs)
mp.figure(1)
mp.plot(x[:,0], x[:,1])
mp.fill_between(x[:,0],x[:,1]-x[:,2],x[:,1]+x[:,2],color='grey',alpha=0.3)
mp.plot(x[:,0], x[:,3])
mp.plot(x[:,0], x[:,4])
#mp.plot(x[:,0], U(x[:,0], U0, a, b))
#mp.plot(x[:,0], gradU(x[:,0], U0, a, b))
mp.show()



