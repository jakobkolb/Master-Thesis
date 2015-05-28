import numpy as np
import matplotlib.pyplot as mp

analytic_rates = np.loadtxt('analytic_rates.csv', delimiter=',')
numeric_rates  = np.loadtxt('numeric_rates.csv',delimiter=',')

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


kf_array=np.zeros((np.shape(analytic_rates)[0],1))
kf_array[:,0]=0.82


mp.plot(analytic_rates[:,0], analytic_rates[:,1],label='analytic rate',color = '0.55')
mp.plot(analytic_rates[:,0], kf_array, 'b-.')
print np.shape(numeric_rates)[1]
for i in [2,3,5,7]:
    mp.plot(numeric_rates[:,0], numeric_rates[:,i], 'ro', markersize=4, label='$\zeta=$'+`np.power(2,i)`, alpha = (i-1)/6.)
ax1.set_ylim([0.7,1.2])
ax1.set_xlim([10**-3,10**2.2])
ax1.legend(loc='upper left')
ax1.set_ylabel(r'$k/k_{S}$')
ax1.set_xlabel(r'$r_{d}$')

ax1.set_xscale('log')

#You must select the correct size of the plot in advance
#fig.set_size_inches(3.54,2.*3.84)
fig.set_size_inches(3.54,2.85)

mp.savefig("conv_symmetric.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )


