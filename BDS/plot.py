#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
#import scipy.optimize as so

a = np.loadtxt('dens_data.out')

print a[0,:]

mp.figure(1)
mp.plot(a[:,0], a[:,1])
mp.fill_between(a[:,0],a[:,1]-a[:,2],a[:,1]+a[:,2],color='grey',alpha=0.3)
mp.show()
