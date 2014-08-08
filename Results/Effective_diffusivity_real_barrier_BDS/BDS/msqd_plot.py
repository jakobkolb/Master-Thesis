import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp
import math

data = np.loadtxt('mean_square_radius.tsv')
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


mp.show()
