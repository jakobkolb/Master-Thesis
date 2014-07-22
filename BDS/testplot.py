
import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit
import os

N = 5
nbins = 1000
pi = 3.14159265359
frames  = 5

densdata = {}
ratedata = {}

#____________________________________#
#Import measured rate data from file #

print 'read data from files '


#____________________________________#
#Import measured rate data from file #

print 'read rate data from files '
for i in range(frames):
    mrate = np.loadtxt(('rate_data%02d' %(i+1)), skiprows=2)
    ratedata[i] = mrate

#____________________________________#
#Import measured dens data from file #

print 'read density data from files'
for i in range(frames):
    dens = np.loadtxt(('dens_data%02d' %(i+1)))
    densdata[i] = dens
print np.shape(densdata[1])

print 'normalize density data'
dr = densdata[0][1,0] - densdata[0][0,0]
for j in range(frames):
    particles = 0
    r = 0
    print np.shape(densdata[j])[0]
    for i in range(0,np.shape(densdata[j])[0]):
        voli = 4./3.*np.pi*((r+dr)**3-r**3)
        r = r + dr
        particles = particles + densdata[j][i,1]+densdata[j][i,3]
        densdata[j][i,1:5] =  densdata[j][i,1:5]/voli
    #print 'N = ', particles
    D = mrate[1]
    Rs = mrate[2]
    rhoinf = (sum(densdata[j][-N:-1,1]+densdata[j][-N:-1,3]))/float(N-1)
    #print np.shape(densdata[j][-N:-1,1])[0]/(N-1)
    #print 'rhoinf = ', rhoinf
    print 'K = ', ratedata[j][11]/(4.*np.pi*D*Rs*rhoinf)
    print 'err K = ', ratedata[j][12]/(4.*np.pi*D*Rs*rhoinf)
fig = mp.figure()
ax = fig.add_subplot(111)

ax.plot(densdata[:,0],densdata[:,1])
ax.plot(densdata[:,0],densdata[:,3])
ax.plot(densdata[10:-1,0],rhoinf/2.0/(1.-1./mrate[3])*(1-0.95/densdata[10:-1,0]))

mp.show()
