#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

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

srates = np.arange(-1,3,0.001)
potential = np.arange(10,11,1)
spacing_parameter = np.arange(0.01,2,0.01)
drange = np.arange(0,10,1)
arates = np.zeros((np.shape(srates)[0],2))
kmax = np.zeros((np.shape(spacing_parameter)[0],np.shape(potential)[0],4))

space_index = -1

for k in spacing_parameter:
    space_index = space_index + 1
    spacing = np.array([1.,1.+k,1.+2*k])
    potential_index = -1
    for u in potential:
        potential_index = potential_index + 1
        for i in range(0,np.shape(srates)[0],1):
            arates[i,1] = calc_rate(u,10**(srates[i]),spacing,kt,d)
            arates[i,0] = 10**(srates[i])

        indices = np.argmax(arates[:,1])
        print indices, spacing, u, arates[indices]
        kmax[space_index,potential_index,:] = [k, u, arates[indices,0], arates[indices,1]]


fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
for i in range(np.shape(potential)[0]):
    mp.plot(kmax[:,i,0], kmax[:,i,2], label='u1 = ' + `kmax[1,i,1]`)

mp.legend(loc='upper right')
ax1.set_xlabel('a')
ax1.set_ylabel('resonant switching rate')
ax1.set_yscale('log')
ax1.set_title('Resonant barrier fluct. rate for constant b-a=2')
ax1.set_xscale('log')

fig2 = mp.figure()
ax2 = fig2.add_subplot(111)
for i in range(np.shape(potential)[0]):
    mp.plot(kmax[:,i,0], kmax[:,i,3], label='u1 = ' + `kmax[1,i,1]`)

ax2.set_xscale('log')
ax2.set_xlabel('a')
ax2.set_ylabel('absorption rate')
mp.legend(loc='upper right')

mp.show()
