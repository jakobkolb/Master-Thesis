import numpy as np
import matplotlib.pyplot as mp

data = np.loadtxt('rate_data.tsv')

fig1 = mp.figure()
ax1 = fig1.add_subplot(111)

mp.plot(data[:,0], data[:,1])
ax1.set_yscale('log')
mp.ylim((max(data[:,1]),min(data[:,1])))

mp.show()
