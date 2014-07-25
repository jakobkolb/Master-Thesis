
import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit
import os

N = 5
nbins = 1000
pi = 3.14159265359
frames  = 4
last_frame = 5
fstep = 1

attdensdata = {}
attmsqddata = {}
attratedata = {}

repdensdata = {}
repratedata = {}
repmsqddata = {}


#____________________________________#
#Import measured rate data from file #

print 'read data from files '


#____________________________________#
#Import measured rate data from file #

print 'read rate data from files '
for i in range(frames):
    mrate = np.loadtxt('att' + `i+1` + ('/rate_data%02d' %last_frame), skiprows=2)
    attratedata[i] = mrate
    mrate = np.loadtxt('rep' + `i+1` + ('/rate_data%02d' %last_frame), skiprows=2)
    repratedata[i] = mrate
#____________________________________#
#Import measured dens data from file #

print 'read density data from files'
for i in range(frames):
    dens = np.loadtxt('att' + `i+1` + ('/dens_data%02d' %last_frame), skiprows=2)
    attdensdata[i] = dens
    dens = np.loadtxt('rep' + `i+1` + ('/dens_data%02d' %last_frame), skiprows=2)
    repdensdata[i] = dens
print np.shape(attdensdata[0])


#____________________________________#
#Import measured msqd data from file #

print 'read density data from files'
for i in range(frames):
    msqd = np.loadtxt('att' + `i+1` + ('/msqd_data%02d' %last_frame), skiprows=2)
    attmsqddata[i] = msqd/(attratedata[i][1]*attratedata[i][3]*6.0)
    msqd = np.loadtxt('rep' + `i+1` + ('/msqd_data%02d' %last_frame), skiprows=2)
    repmsqddata[i] = msqd/(attratedata[i][1]*attratedata[i][3]*6.0)


print 'normalize density data'
fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
dr = attdensdata[0][1,0] - attdensdata[0][0,0]
Km = 0
rdatt = [10**(-2),10**(-1),2.5,10**2]
rdrep = [10**(-3),10**(-1),2.5,10**2]
for j in range(frames):
    r = 0
    for i in range(0,np.shape(attdensdata[j])[0]):
        voli = 4./3.*np.pi*((r+dr)**3-r**3)
        r = r + dr
        attdensdata[j][i,1:5] =  attdensdata[j][i,1:5]/voli
        repdensdata[j][i,1:5] =  repdensdata[j][i,1:5]/voli
    #print 'N = ', particles
    Datt = attratedata[j][1]
    Drep = repratedata[j][1]
    Rdatt = attratedata[j][2]
    Rdatt = repratedata[j][2]
    attrhoinf = (sum(attdensdata[j][-N:-1,1]+attdensdata[j][-N:-1,3]))/float(N-1)
    reprhoinf = (sum(repdensdata[j][-N:-1,1]+repdensdata[j][-N:-1,3]))/float(N-1)
    #print np.shape(densdata[j][-N:-1,1])[0]/(N-1)
    #print 'rhoinf = ', rhoinf
    #K = ratedata[j][12]/(4.*np.pi*D*Rs*rhoinf*(1+ratedata[j][2]/ratedata[j][3]))
    Katt = attratedata[j][12]/(4.*np.pi*Datt*attrhoinf)
    Krep = repratedata[j][12]/(4.*np.pi*Drep*reprhoinf)
#    print 'K = ', K
    eKatt = attratedata[j][13]/(4.*np.pi*Datt*attrhoinf)
    eKrep = repratedata[j][13]/(4.*np.pi*Drep*reprhoinf)

#    print 'err K = ', eK 
    ax1.errorbar(rdatt[j],Katt,yerr = eKatt,fmt='bo')
    ax1.errorbar(rdrep[j],Krep,yerr = eKrep,fmt='ro')
ax1.set_xscale('log')
r1 = 18
r2 = -1
drs = 0

#PLOT DATA FOR ATTRACTIVE BARRIER

fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
for i in range(frames):
#    ax1.plot(attdensdata[i][:,0],attdensdata[i][:,1])
#    ax1.plot(attdensdata[i][:,0],attdensdata[i][:,3])
    ax1.plot(attdensdata[i][:,0],(attdensdata[i][:,1]+attdensdata[i][:,3])/2.)

fig3 = mp.figure()
ax3 = fig3.add_subplot(111)
for i in range(frames):
    ax3.plot(attdensdata[i][0:-1,0],attmsqddata[i][0:-1,1])
    ax3.plot(attdensdata[i][0:-1,0],attmsqddata[i][0:-1,3])

fig31 = mp.figure()
ax31 = fig31.add_subplot(111)
for i in range(frames):
    ax31.plot(attdensdata[i][0:-1,0],(attmsqddata[i][0:-1,1]+attmsqddata[i][0:-1,3])/2.)

#PLOT DATA FOR REPULSIVE BARRIER

fig5 = mp.figure()
ax5 = fig5.add_subplot(111)
for i in range(frames):
#    ax5.plot(repdensdata[i][:,0],repdensdata[i][:,1])
#    ax5.plot(repdensdata[i][:,0],repdensdata[i][:,3])
    ax5.plot(repdensdata[i][:,0],(repdensdata[i][:,1]+repdensdata[i][:,3])/2.)

fig7 = mp.figure()
ax7 = fig7.add_subplot(111)
for i in range(frames):
    ax7.plot(repdensdata[i][0:-1,0],repmsqddata[i][0:-1,1])
    ax7.plot(repdensdata[i][0:-1,0],repmsqddata[i][0:-1,3])

fig71 = mp.figure()
ax71 = fig71.add_subplot(111)
for i in range(frames):
    ax71.plot(repdensdata[i][0:-1,0],(repmsqddata[i][0:-1,1]+repmsqddata[i][0:-1,3])/2.)
#ax7.set_yscale('log')
#ax7.set_yscale('log')

fig8 = mp.figure()
ax8 = fig8.add_subplot(111)
for i in range(frames):
    ax8.plot(repdensdata[i][0:-1,0],repmsqddata[i][0:-1,5]+1)
ax8.set_yscale('log')
mp.show()
