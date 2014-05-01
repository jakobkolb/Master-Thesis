import numpy as np
import matplotlib.pyplot as mp

data = np.loadtxt('rhovals.tsv')
r_n = data[:,0]
rho_n = data[:,1]
u_n = data[:,2]
kd=1

resolution = np.shape(data)[0]

d_n = np.zeros((resolution))
d_n[0]=1
for i in range(resolution-1):
    dsum = 0.
    for j in range(i-1):
        dsum += np.exp(u_n[j])/(d_n[j]*r_n[j]**2)
    print i
    d_n[i] = (r_n[i]**2*np.exp(-u_n[i]))/(4*np.pi*rho_n[i]*np.exp(u_n[i])/(kd*(r_n[i+1]-r_n[i])) - dsum)
    print dsum, d_n[i]
d_n[0] = 1
fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
mp.plot(r_n, d_n)
mp.plot(r_n, rho_n)

fig2 = mp.figure()
ax2 = fig2.add_subplot(111)
mp.plot(r_n, u_n)

mp.show()
