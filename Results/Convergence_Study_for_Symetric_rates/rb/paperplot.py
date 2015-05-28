import numpy as np
import matplotlib.pyplot as mp

analytic_rates = np.loadtxt('analytic_rates.csv', delimiter=',')
numeric_rates  = np.loadtxt('numeric_rates.csv',delimiter=',')

print np.shape(numeric_rates)

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

a=6
b=11
u=2

kd = 0.5*(1+a*b/(a*b-(b-a)*(1-np.exp(u))))
kd_array=np.zeros((np.shape(analytic_rates)[0],1))
kd_array[:,0]=0.82

print kd

print kd_array[1,0]

mp.plot(analytic_rates[:,0], analytic_rates[:,1],label='analytic rate',color = '0.55')
mp.plot(analytic_rates[:,0], kd_array, 'b--')
for i in [3,4,5,6]:
    print i
    mp.plot(numeric_rates[:,0], numeric_rates[:,i], 'ro', markersize=4, label='$\zeta=$'+`np.power(2,i+1)`, alpha = i/8.)
ax1.set_ylim([0.7,1.2])
ax1.set_xlim([10**-3,10**2])
ax1.legend(loc='upper left')
ax1.set_ylabel(r'$K/K_{S}$')
ax1.set_xlabel(r'$r_{d}$')

ax1.set_xscale('log')

#You must select the correct size of the plot in advance
#fig.set_size_inches(3.54,2.*3.84)
fig.set_size_inches(3.54,2.64)

mp.savefig("conv_symmetric.pdf",
            #This is simple recomendation for publication plots
            dpi=1000,
            # Plot will be occupy a maximum of available space
            bbox_inches='tight',
            )


