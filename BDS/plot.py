#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
#import scipy.optimize as so

a = np.loadtxt('dens_data.out')

print np.shape(a)[0]
particles = 0
threequarterstimespi = 4/3*np.pi
dr = a[1,0] - a[0,0]
r = 0
for i in range(0,np.shape(a)[0]):
    voli = threequarterstimespi*((r+dr)**3-r**3)
    r = r + dr
    particles = particles + a[i,1]
    a[i,1:3] =  a[i,1:3]/voli

print particles

mp.figure(1)
mp.plot(a[:,0], a[:,1])
mp.fill_between(a[:,0],a[:,1]-a[:,2],a[:,1]+a[:,2],color='grey',alpha=0.3)
mp.show()
