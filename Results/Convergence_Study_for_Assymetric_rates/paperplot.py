import numpy as np
import matplotlib.pyplot as mp

analytic_rates = np.loadtxt('analytic_rates.csv', delimiter=',')
numeric_rates  = np.loadtxt('numeric_rates.csv',delimiter=',')
print analytic_rates

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

fig = mp.figure()
ax1 = fig.add_subplot(111)

mp.plot(analytic_rates[:,0], analytic_rates[:,1],label='analytic \n solution', color = '0.55')
for i in range(2,7):
    mp.plot(numeric_rates[:,0], numeric_rates[:,i]/numeric_rates[-1,i], 'ro', label='$\zeta=$'+`np.power(2,i)`, alpha=(i-1)/5., markersize = 4)
ax1.set_ylim([0.95,1.9])
ax1.legend()
ax1.set_ylabel(r'$k/k_{S}$')
ax1.set_xlabel(r'$W_{10}$')

ax1.set_xscale('log')

#You must select the correct size of the plot in advance
#fig.set_size_inches(3.54,2.*3.84)
fig.set_size_inches(3.54,2.85)

mp.savefig("conv_rates_for_barrier_transition.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )


