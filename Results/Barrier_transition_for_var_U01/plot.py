import numpy as np
import matplotlib.pyplot as mp

rates = np.loadtxt('analytic_rates_for_var_U01.csv', delimiter=',')


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
for i in range(1,6):
    mp.plot(rates[:,0], rates[:,i], label='U1='+`i*2-6`)

ax1.legend(loc='lower right')
ax1.set_xscale('log')
ax1.set_xlabel(r'$W_{12}$')
ax1.set_ylabel(r'$K/4 \pi D$')

#You must select the correct size of the plot in advance
#fig.set_size_inches(3.54,2.*3.84)
fig.set_size_inches(3.54,3.54)

mp.savefig("rates_for_barrier_transition.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )

