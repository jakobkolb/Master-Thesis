
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as mp
from mpl_toolkits.axes_grid1 import host_subplot
import mpl_toolkits.axisartist as AA
from scipy.weave import inline
from scipy.weave import converters

def theta(x):
    return 0.5*(np.sign(x)+1)

data = np.loadtxt('rhovals.tsv')
resolution = np.shape(data)[0]
r_n = data[:,0]
rho_n = data[:,3]

kd=1
kd=1
d = 1.
a = 6.
b = 11.
Ua = -3.
Ur = 3.
Uma = -1.5
Umr = 1.5
rd = [250,2.5,0.25]
l = a-1.
g = (b-a)/l
pi = np.pi

Um = 1.5
pi = np.pi

u_n = np.zeros((resolution))
for i in range(resolution):
    u_n[i] = Um*(theta(r_n[i]-a)-theta(r_n[i]-b))


d_n = np.loadtxt('effective_d_profile.tsv')
rho_eval = np.loadtxt('mapped_rho.tsv')


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
dens_ax = fig2.add_subplot(111)
pot_ax = dens_ax.twinx()
l1 = dens_ax.plot(r_n, rho_eval, 'r-', label = 'mapping')
l2 = dens_ax.plot(r_n, rho_n, 'b:', label = 'measured')
l3 = pot_ax.plot(r_n, u_n, color='0.55', label = 'potential')
dens_ax.set_ylabel(r'$\rho_{tot}(r)$')
pot_ax.set_ylabel(r'$U_{m}(r)$')
dens_ax.set_xlabel('r')

lns = l1+l2+l3
labs = [l.get_label() for l in lns]
dens_ax.legend(lns, labs, loc='upper right')

mp.savefig("reverse_dens.pdf",
        #This is simple recomendation for publication plots
        dpi=1000,
        # Plot will be occupy a maximum of available space
        bbox_inches='tight',
        )
params = {'text.usetex' : True,
          'font.size' : 10,
          'legend.fontsize' : 10,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params)



fig1 = mp.figure()
fig1.set_size_inches(3.54,2.64)
ax1 = fig1.add_subplot(111)
ax1.plot(r_n[2:-1], d_n[2:-1], 'r', label = r'$D_{eff}(r)$')
ax1.plot(r_n, np.ones((resolution)), color='0.55', label = r'$D_0(r)$')
ax1.set_yscale('log')
ax1.set_xlabel(r'$r$')
ax1.set_ylabel(r'$D$')

mp.legend(loc='upper right')

mp.savefig("effective_diffusivity.pdf",
        #This is simple recomendation for publication plots
        dpi=1000,
        # Plot will be occupy a maximum of available space
        bbox_inches='tight',
        )

