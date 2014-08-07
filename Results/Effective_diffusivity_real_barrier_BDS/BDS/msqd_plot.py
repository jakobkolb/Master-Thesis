import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp

data = np.loadtxt('mean_square_radius.tsv')
parameters = np.loadtxt('rate_data01', skiprows=2)


def powerlaw(t,D,alpha):
    return 2.0*D*np.power(t,alpha)

cutoff = 10
nbins = np.shape(data)[1]
ntimes = np.shape(data)[0]
dt = float(parameters[3])
times = dt*np.arange(0,ntimes)

fitparameters = np.zeros((nbins,2))

fig = mp.figure()

ax1 = fig.add_subplot(131)
ax2 = fig.add_subplot(132)
ax3 = fig.add_subplot(133)

for ibin in range(cutoff,nbins-cutoff):
    par, cov = cp.curve_fit(powerlaw, times, data[:,ibin])
    if par[0] != 1:
        ax1.plot(times, data[:,ibin])
        ax2.plot(ibin, par[0], 'o')
        ax3.plot(ibin, par[1], 'o')
    print ibin, par[0]
    print ibin, par[1]


mp.show()
