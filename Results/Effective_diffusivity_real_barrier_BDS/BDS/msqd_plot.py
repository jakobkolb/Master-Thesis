import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp
import math

data = np.loadtxt('mean_square_radius.tsv')
edata = np.loadtxt('Emean_square_radius.tsv')

def powerlaw(t,D):
    return 2.0*D*t

cutoff = 1
t1 = 20
t2 = 30
Rs = 1.
Rd = 20.
nbins = np.shape(data)[1]
rvals = Rs*np.arange(nbins)/nbins - Rs
ntimes = np.shape(data)[0]
dt = float(parameters[3])

fit = np.zeros((nbins))
efit = np.zeros((nbins))

fig = mp.figure()

ax1 = fig.add_subplot(131)
ax2 = fig.add_subplot(132)
ax3 = fig.add_subplot(133)

for ibin in range(cutoff,nbins-cutoff-1):
    ax1.plot(data[t1:t2,-1]-data[0,-1],data[t1:t2,ibin])
    ax1.fill_between(data[t1:t2,-1]-data[0,-1],data[t1:t2,ibin]-edata[t1:t2,ibin],data[t1:t2,ibin]+edata[t1:t2,ibin], color='grey', alpha = 0.3)



for ibin in range(cutoff,nbins-cutoff-1):
    par, cov = cp.curve_fit(powerlaw, data[t1:t2,-1]-data[0,-1], data[t1:t2,ibin], sigma = edata[t1:t2,ibin], absolute_sigma=True)
    print par,cov
    fit[ibin] = par
    efit[ibin] = np.sqrt(cov)
#    if par[0] != 1:
#    ax2.plot(ibin, par[0], 'o')
#    ax3.plot(ibin, par[1], 'o')
ax2.plot(rvals,fit)
ax2.fill_between(rvals,fit-2*efit,fit+2*efit, color = 'grey')
ax3.plot(efit)

mp.show()
