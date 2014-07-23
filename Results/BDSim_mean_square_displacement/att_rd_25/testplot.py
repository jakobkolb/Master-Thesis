
import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit
import os

N = 5
nbins = 1000
pi = 3.14159265359
frames  = 18
fmin = 10
fstep = 1

densdata = {}
ratedata = {}
msqddata = {}


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


#____________________________________#
#Import measured dens data from file #

print 'read density data from files'
for i in range(frames):
    msqd = np.loadtxt(('msqd_data%02d' %(i+1)))
    print ratedata[i][1]
    print ratedata[i][3]
    msqddata[i] = msqd/np.sqrt(ratedata[i][1]*ratedata[i][3]*6.)


print 'normalize density data'
fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
dr = densdata[0][1,0] - densdata[0][0,0]
Km = 0
for j in range(fmin,frames,fstep):
    particles = 0
    r = 0
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
    #K = ratedata[j][12]/(4.*np.pi*D*Rs*rhoinf*(1+ratedata[j][2]/ratedata[j][3]))
    K = ratedata[j][12]/(4.*np.pi*D*rhoinf)
    Km += K
#    print 'K = ', K
    eK = ratedata[j][13]/(4.*np.pi*D*rhoinf)

#    print 'err K = ', eK 
    ax1.errorbar(ratedata[j][6]*ratedata[j][1]/(1+ratedata[j][9]*(1+ratedata[j][10]))**2,K,yerr = eK,fmt='o')
Km = Km/(frames-fmin)
print Km

r1 = 18
r2 = -1
drs = 0

densdata[frames+1] = densdata[fmin]
for i in range(fmin+1,frames):
    densdata[frames+1] = densdata[frames+1]+densdata[i]
densdata[frames+1] = densdata[frames+1]/(frames-fmin)


msqddata[frames+1] = msqddata[fmin]
for i in range(fmin+1,frames):
    msqddata[frames+1] = msqddata[frames+1]+msqddata[i]
msqddata[frames+1] = msqddata[frames+1]/(frames-fmin)

fig = mp.figure()
ax = fig.add_subplot(111)
for i in range(fmin,frames,fstep):
    ax.plot(densdata[i][:,0],densdata[i][:,1])
    ax.plot(densdata[i][:,0],densdata[i][:,3])

fig2 = mp.figure()
ax2 = fig2.add_subplot(111)
ax2.plot(densdata[frames+1][:,0], densdata[frames+1][:,1])
ax2.plot(densdata[frames+1][:,0], densdata[frames+1][:,3])
ax2.plot(densdata[frames+1][:,0], (densdata[frames+1][:,1]+densdata[frames+1][:,3])/2)

fig3 = mp.figure()
ax3 = fig3.add_subplot(111)
for i in range(fmin,frames,fstep):
    ax3.plot(msqddata[i][0:-1,0],msqddata[i][0:-1,1])
    ax3.plot(msqddata[i][0:-1,0],msqddata[i][0:-1,3])

fig4 = mp.figure()
ax4 = fig4.add_subplot(111)
ax4.plot(msqddata[frames+1][0:-1,0], msqddata[frames+1][0:-1,1])
ax4.plot(msqddata[frames+1][0:-1,0], msqddata[frames+1][0:-1,3])
ax4.plot(msqddata[frames+1][0:-1,0], (msqddata[frames+1][0:-1,1]+msqddata[frames+1][0:-1,3])/2)


mp.show()
