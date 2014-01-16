#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from mpl_toolkits.mplot3d import Axes3D


def k(rs,a,b,u,d):
    return 4.*np.pi*rs*d/((np.exp(u)-1)*(1/a-1/b)+1)

def kdiff(rs,a,b,u,d):
    return 1/2.*(k(rs,a,b,0,d)+k(rs,a,b,u,d))-k(rs,a,b,u/2.,d)

fig = mp.figure()
ax = Axes3D(fig)

uvals = np.arange(-100,100,0.1)
avals = np.arange(1,10,0.1)

uvals, avals = np.meshgrid(uvals, avals)

kvals = 1/2.*(k(1,avals,avals+2,uvals,1)+k(1,avals,avals+2,0,1))-k(1,avals,avals+2,uvals/2.,1)

plot = ax.plot_surface(uvals, avals, kvals)

ax.set_xlabel('U')
ax.set_ylabel('a')

mp.show()
