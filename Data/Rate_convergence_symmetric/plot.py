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

mp.plot(analytic_rates[:,0], analytic_rates[:,1],label='analytic \n solution')
for i in range(1,5):
    mp.plot(numeric_rates[:,0], numeric_rates[:,i], 'o', label='n='+`np.power(2,i)`)

ax1.legend()
ax1.set_ylabel(r'$K/4 \pi D$')
ax1.set_xlabel(r'$r_{d}$')

ax1.set_xscale('log')

#You must select the correct size of the plot in advance
#fig.set_size_inches(3.54,2.*3.84)
fig.set_size_inches(3.54,3.54)

mp.savefig("rates_for_barrier_transition.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )


