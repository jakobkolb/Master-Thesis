import numpy as np
import matplotlib.pyplot as mp

data = np.loadtxt('rhovals.tsv')
r_n = data[:,0]
rho_n = data[:,1]
u_n = data[:,2]
kd=1

resolution = np.shape(data)[0]

d_n = np.zeros((resolution))
rho_eval = np.zeros((resolution))

d_n[0]=1
for i in range(1,resolution-1):
    dsum = 0.
    for j in range(i-1):
        dsum += np.exp(u_n[j])/(d_n[j]*r_n[j]**2)
        if (d_n[j]*r_n[j] == 0):
            print 'ERROR', i, j
    d_n[i] = (r_n[i]**2*np.exp(-u_n[i]))/(4*np.pi*rho_n[i]*np.exp(u_n[i])/(kd*(r_n[i+1]-r_n[i])) - dsum)
print i
for i in range(resolution-1):
    dsum = 0
    for j in range(i-1):
        dsum += (r_n[j+1]-r_n[j])*np.exp(u_n[j])/(d_n[j]*r_n[j]**2)
    rho_eval[i]=kd/(4*np.pi)*np.exp(-u_n[i])*dsum
print i
d_n[0] = 1
#Direct input
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern}"]
#Options
params = {'text.usetex' : True,
          'font.size' : 10,
          'legend.fontsize' : 10,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params)


fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
mp.plot(r_n, d_n)
mp.plot(r_n, rho_n)

ax1.set_ylim([-1,2])

mp.savefig("effective_d_profile.pdf",
        #This is simple recomendation for publication plots
        dpi=1000,
        # Plot will be occupy a maximum of available space
        bbox_inches='tight',
        )



fig2 = mp.figure()
ax2 = fig2.add_subplot(111)
mp.plot(r_n, rho_eval)
mp.plot(r_n, rho_n)

mp.savefig("reverse_dens.pdf",
        #This is simple recomendation for publication plots
        dpi=1000,
        # Plot will be occupy a maximum of available space
        bbox_inches='tight',
        )


