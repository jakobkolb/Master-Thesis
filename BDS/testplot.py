
import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit

N = 5
nbins = 1000
pi = 3.14159265359

#____________________________________#
#Import measured rate data from file #

print 'read data from files '


#____________________________________#
#Import measured rate data from file #

print 'read rate data from files '

mrate = np.loadtxt('rate_data.out', skiprows=2)

#____________________________________#
#Import measured dens data from file #

print 'read density data from files'

densdata = np.loadtxt('dens_data.out')
print np.shape(densdata)

print 'normalize density data'

particles = 0
r = 0
dr = densdata[1,0] - densdata[0,0]
for i in range(0,np.shape(densdata)[0]):
    voli = 4./3.*np.pi*((r+dr)**3-r**3)
    r = r + dr
    particles = particles + densdata[i,1]+densdata[i,3]
    densdata[i,1:5] =  densdata[i,1:5]/voli
print 'N = ', particles
D = mrate[1]
Rs = mrate[2]
rhoinf = (sum(densdata[-N:-1,1]+densdata[-N:-1,3]))/float(N-1)
print np.shape(densdata[-N:-1,1])[0]/(N-1)
print 'rhoinf = ', rhoinf
print 'K = ', mrate[11]/(4.*np.pi*D*Rs*rhoinf)
print 'err K = ', mrate[12]/(4.*np.pi*D*Rs*rhoinf)
fig = mp.figure()
ax = fig.add_subplot(111)

ax.plot(densdata[:,0],densdata[:,1])
ax.plot(densdata[:,0],densdata[:,3])
ax.plot(densdata[10:-1,0],rhoinf/2.0/(1.-1./mrate[3])*(1-0.95/densdata[10:-1,0]))

mp.show()
