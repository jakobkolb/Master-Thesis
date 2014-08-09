import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp
import math

data = np.loadtxt('mean_square_radius.tsv')
<<<<<<< HEAD
edata = np.loadtxt('Emean_square_radius.tsv')
parameters = np.loadtxt('rate_data01', skiprows=2)


def powerlaw(t,D):
    return 2.0*D*t

cutoff = 1
t1 = 20
t2 = 30
nbins = np.shape(data)[1]
ntimes = np.shape(data)[0]
dt = float(parameters[3])

fit = np.zeros((nbins))
efit = np.zeros((nbins))

fig = mp.figure()

ax1 = fig.add_subplot(121)
ax2 = fig.add_subplot(122)
#ax3 = fig.add_subplot(133)

for ibin in range(cutoff,nbins-cutoff-1):
    ax1.plot(data[t1:t2,-1]-data[0,-1],data[t1:t2,ibin])
    ax1.fill_between(data[t1:t2,-1]-data[0,-1],data[t1:t2,ibin]-edata[t1:t2,ibin],data[t1:t2,ibin]+edata[t1:t2,ibin], color='grey', alpha = 0.3)



for ibin in range(cutoff,nbins-cutoff-1):
    par, cov = cp.curve_fit(powerlaw, data[t1:t2,-1]-data[0,-1], data[t1:t2,ibin], sigma = edata[t1:t2,ibin])
    print par,cov
    fit[ibin] = par
    efit[ibin] = np.sqrt(cov)
#    if par[0] != 1:
#    ax2.plot(ibin, par[0], 'o')
#    ax3.plot(ibin, par[1], 'o')
ax2.plot(fit)
ax2.fill_between(fit-efit,fit+efit)
=======
parameters = np.loadtxt('rate_data01', skiprows=2)


def powerlaw(t,D,alpha):
    return 2.0*D*np.power(t,alpha)

cutoff = 20
nbins = np.shape(data)[1]
ntimes = np.shape(data)[0]
dt = float(parameters[3])
times = dt*np.arange(0,ntimes)

fitparameters = np.zeros((nbins,2))

fig = mp.figure()

ax1 = fig.add_subplot(111)
#ax2 = fig.add_subplot(132)
#ax3 = fig.add_subplot(133)

mdata = np.zeros(np.shape(data[:,cutoff]))
print mdata
for ibin in range(cutoff,nbins-cutoff):
    for j in range(np.shape(data[:,ibin])[0]):
        if not math.isnan(data[j,ibin]):
            mdata[j] = mdata[j] + data[j,ibin]
    ax1.plot(times,data[:,ibin])
ax1.plot(times, mdata/float(nbins-2*cutoff))

for ibin in range(cutoff,nbins-cutoff):
    par, cov = cp.curve_fit(powerlaw, times, data[:,ibin])
#    if par[0] != 1:
#    ax2.plot(ibin, par[0], 'o')
#    ax3.plot(ibin, par[1], 'o')
>>>>>>> 9cdd54589e7c3ef1f5632549fa4c04677abcdfb6


mp.show()
