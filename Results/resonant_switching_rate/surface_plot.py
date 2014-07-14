import pickle
import matplotlib.pyplot as mp
import numpy as np

with open('resonance_data.p', 'rb') as ro:
    data = pickle.load(ro)

M = np.shape(data)[0]
N = np.shape(data)[1]

print M,N
print data

#format of data is data[t_index,g_index] = [t, g, rd_res, K_res]

t_values = data[:,0,0]
g_values = data[0,:,1]

rd_res = data[:,:,2]
K_res = data[:,:,3]

fig = mp.figure()

ax1 = fig.add_subplot(121)
kplot = ax1.pcolor(t_values,g_values,K_res)

ax1.set_xscale('log')
ax1.set_yscale('log')

mp.colorbar(kplot)

ax2 = fig.add_subplot(122)
rdplot = ax2.pcolor(t_values,g_values,rd_res)

ax2.set_xscale('log')
ax2.set_yscale('log')
ax2.set_zscale('log')
mp.colorbar(rdplot)

mp.show()
