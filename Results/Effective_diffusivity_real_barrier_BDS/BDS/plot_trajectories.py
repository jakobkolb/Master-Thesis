import numpy as np
import matplotlib.pyplot as mp
from scipy.weave import inline
from scipy.weave import converters

data = np.loadtxt('trajectories.txt')

parameters = np.loadtxt('rate_data01', skiprows=2)

nbins  = int(100)
npar = int(np.shape(data)[1])
Rs = float(1)
Rd = float(20)
ntimes = int(np.shape(data)[0])
it0max = ntimes/4
sqd = np.zeros((ntimes,nbins,2))
msqd = np.zeros((ntimes,nbins))
print np.shape(msqd)

mp.figure()
n = 0
for i in range(npar):
    if data[0,i]>0.99*Rd:
        n += 1
        print i, data[0,i]
        msqd[:,0] += (data[:,i]-data[0,i])**2

msqd[:,0] = msqd[:,0]/n
mp.plot(data[:,0], msqd[:,0])
mp.show()
