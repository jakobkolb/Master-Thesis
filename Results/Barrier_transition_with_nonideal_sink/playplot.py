import numpy as np
import matplotlib.pyplot as mp
names = ['01','1','10']
ksurf = [0.1,1.,10.]
for j, name in enumerate(names):
    #rates = np.loadtxt('analytic_rates_for_var_U01.csv', delimiter=',')
    rates = np.loadtxt('rate_data'+name+'.tsv')


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
    kr = ksurf[j]
    ks = kr/(1+kr)
    fig = mp.figure()
    ax1 = fig.add_subplot(111)
    for i in range(1,6):
        if i in [1,2]:
            mp.plot(rates[:,0], rates[:,i]/ks, 'r-.', label=r'$U_1=$'+`i*2-6` + r'$~k_B T$', alpha = i/2.)
        elif i == 3:
            mp.plot(rates[:,0], rates[:,i]/ks, color = '0.55', label=r'$U_1=$'+`i*2-6` + r'$~k_B T$')
        elif i in [4,5]:
            mp.plot(rates[:,0], rates[:,i]/ks, 'b--', label=r'$U_1=$'+`i*2-6` + r'$~k_B T$', alpha = (6-i)/2.)

    ax1.text(0.65, 0.95, '$k_{surf} =$' + `ksurf[j]`, transform=ax1.transAxes, fontsize=12, va='top')

    ax1.legend(loc='lower right')
    ax1.set_xscale('log')
    #ax1.set_yticks([0.7,1.2,0.1])
    ax1.set_xlabel(r'$W_{10}$')
    ax1.set_ylabel(r'$k/k_{S}$')

    #You must select the correct size of the plot in advance
    #fig.set_size_inches(3.54,2.*3.84)
    fig.set_size_inches(3.54,2.64)

    mp.savefig('non_perfect_sink_transition'+name+'.pdf',
                #This is simple recomendation for publication plots
                dpi=1000,
                # Plot will be occupy a maximum of available space
                bbox_inches='tight',
                )


