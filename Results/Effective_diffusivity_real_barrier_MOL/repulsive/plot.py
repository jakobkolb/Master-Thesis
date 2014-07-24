
import numpy as np
import os
import matplotlib.pyplot as mp
from mpl_toolkits.axes_grid1 import host_subplot

data = np.loadtxt('rhovals.tsv')
r_n = data[:,0]
u_n = data[:,2]
kd=1

resolution = np.shape(data)[0]
d_n = np.zeros((resolution,1))
tmp = np.zeros((resolution,1))
k = 0

for i, directory in enumerate(os.listdir('.')):
    if 'repulsive_rd_' in directory:
        k+=1
        tmp[:,0] = np.loadtxt(directory + '/effective_d_profile.tsv')
        d_n = np.append(d_n, tmp, axis=1)
print np.shape(d_n)

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

fig2 = mp.figure()
fig2.set_size_inches(3.54,2.64)
d_ax = fig2.add_subplot(111)
pot_ax = d_ax.twinx()

l1 = d_ax.plot(r_n[2:-1], d_n[2:-1,1], 'r:', label = r'$r_d = 20$')
l2 = d_ax.plot(r_n[2:-1], d_n[2:-1,2], 'r-.', label = r'$r_d = 2$')
l3 = d_ax.plot(r_n[2:-1], d_n[2:-1,3], 'r--', label = r'$r_d = 0.5$')
l4 = pot_ax.plot(r_n, u_n, color='0.55', label = 'potential')
d_ax.set_ylabel(r'$D_{eff}(r)$')
pot_ax.set_ylabel(r'$U_{m}(r)$')
d_ax.set_xlabel('r')
d_ax.set_yscale('log')

lns = l1+l2+l3+l4
labs = [l.get_label() for l in lns]
d_ax.legend(lns, labs, loc='lower right')
mp.savefig("diff.pdf",
        #This is simple recomendation for publication plots
        dpi=1000,
        # Plot will be occupy a maximum of available space
        bbox_inches='tight',
        )

