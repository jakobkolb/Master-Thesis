import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp

data = np.loadtxt('mean_square_radius.tsv')
parameters = np.loadtxt('rate_data01', skiprows=2)


def powerlaw(t,D,c):
    return D*t


def powerlaw2(t,D,c):
    return D*t+c

Rs = 1
Rd = 20

tcut = 10
bcut = 20
i0 = 1
i1 = 70
i2 = int(np.shape(data)[0])
nbins = np.shape(data)[1]
ntimes = np.shape(data)[0]
dt = float(parameters[3])
times = dt*np.arange(0,ntimes)
print np.shape(data)

fitparameters = np.zeros((nbins,2))

print cp.curve_fit(powerlaw, times[i0:i1], data[i0:i1,10])

fig = mp.figure()

ax1 = fig.add_subplot(221)
ax2 = fig.add_subplot(222)
ax3 = fig.add_subplot(223)
ax4 = fig.add_subplot(224)

for ibin in range(bcut,nbins-tcut):
    print ibin
    par, cov = cp.curve_fit(powerlaw, times[i0:i1], data[i0:i1,ibin])
    if par[0]>0 : 
        ax1.plot(times[i0:i1], data[i0:i1,ibin])
        ax2.plot(Rs+ibin/float(nbins)*(Rd-Rs), par[0], 'o')
        ax3.plot(Rs+ibin/float(nbins)*(Rd-Rs), par[0], 'o')
        ax4.plot(Rs+ibin/float(nbins)*(Rd-Rs), par[0], 'o')

fig = mp.figure()

ax1 = fig.add_subplot(221)
ax2 = fig.add_subplot(222)
ax3 = fig.add_subplot(223)
ax4 = fig.add_subplot(224)

for ibin in range(bcut,nbins-tcut):
    print ibin
    ax1.plot(times[i1:i2], data[i1:i2,ibin])
    par, cov = cp.curve_fit(powerlaw2, times[i1:i2], data[i1:i2,ibin])
    if par[0]>0 : 
        ax2.plot(Rs+ibin/float(nbins)*(Rd-Rs), par[0], 'o')
        ax3.plot(Rs+ibin/float(nbins)*(Rd-Rs), par[1], 'o')
        ax4.plot(Rs+ibin/float(nbins)*(Rd-Rs), par[1], 'o')



mp.show()
for ibin in range(bcut,nbins-tcut):
    par, cov = cp.curve_fit(powerlaw, times[i1:i2], data[i1:i2,ibin])
    if par[0]>0 : 
        ax2.plot(Rs+ibin*(Rd-Rs), par[0], 'o')
        ax3.plot(Rs+ibin*(Rd-Rs), par[1], 'o')




mp.show()
