import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp

data = np.loadtxt('mean_square_radius.tsv')
parameters = np.loadtxt('rate_data01', skiprows=2)


def powerlaw(t,D,alpha):
    return D*np.power(t,alpha)

cutoff = 10
i0 = 1
i1 = 1000
i2 = 5000
nbins = np.shape(data)[1]
ntimes = np.shape(data)[0]
dt = float(parameters[3])
times = dt*np.arange(0,ntimes)

fitparameters = np.zeros((nbins,2))

print cp.curve_fit(powerlaw, times[i0:i1], data[i0:i1,10])

fig = mp.figure()

ax1 = fig.add_subplot(131)
ax2 = fig.add_subplot(132)
ax3 = fig.add_subplot(133)

for ibin in range(cutoff,nbins-cutoff):
    par, cov = cp.curve_fit(powerlaw, times[i0:i1], data[i0:i1,ibin])
    ax1.plot(times[i0:i1], data[i0:i1,ibin])
    ax2.plot(ibin, par[0], 'o')
    ax3.plot(ibin, par[1], 'o')

fig = mp.figure()

ax1 = fig.add_subplot(131)
ax2 = fig.add_subplot(132)
ax3 = fig.add_subplot(133)

for ibin in range(cutoff,nbins-cutoff):
    par, cov = cp.curve_fit(powerlaw, times[i1:i2], data[i1:i2,ibin])
    ax1.plot(times[i1:i2], data[i1:i2,ibin])
    ax2.plot(ibin, par[0], 'o')
    ax3.plot(ibin, par[1], 'o')



mp.show()
