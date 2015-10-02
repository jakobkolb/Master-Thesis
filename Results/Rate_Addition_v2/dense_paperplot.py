import numpy as np
import matplotlib.pyplot as mp
import matplotlib.patches as mpatches

axisfontsize = 14
legendfontsize = 13

reds =  ['#660000', '#CC0000', '#FF3333', '#FF9999']
blues = ['#004C99', '#0080FF', '#66B2FF', '#CCE5FF']
papercolors = [ 'red', 'blue', 'green']


Keff_att = {}
Keff_rep = {}
Kbc_att = {}
Kbc_rep = {}
Knum_att = {}
Knum_rep = {}

Ksvals = ['0.1','1','10']
nKsvals = [0.1,1,10]

for i, k in enumerate(Ksvals):
    print i, k

    Keff_tmp_att = np.loadtxt('attasumption'+Ksvals[i]+'.tsv')
    Keff_tmp_rep = np.loadtxt('repasumption'+Ksvals[i]+'.tsv')
    Kbc_tmp_att = np.loadtxt('attanalytics'+Ksvals[i]+'.tsv')
    Kbc_tmp_rep = np.loadtxt('repanalytics'+Ksvals[i]+'.tsv')
    
    Keff_att[i] = Keff_tmp_att
    Keff_rep[i] = Keff_tmp_rep
    Kbc_att[i] = Kbc_tmp_att
    Kbc_rep[i] = Kbc_tmp_rep

N = 2*np.shape(Keff_tmp_att)[0]/5

Knum_att = np.loadtxt('att_numeric_rates.csv', delimiter=',')
Knum_rep = np.loadtxt('rep_numeric_rates.csv', delimiter=',')

a=6
b=11
ur=3
ua=-3

Kd_rep = 0.831
Kd_att = 1.122

fig1 = mp.figure()
ax1 = fig1.add_subplot(111)

j = 1

#Direct input 
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern, MnSymbol}"]
#Options
params = {'text.usetex' : True,
          'font.size' : axisfontsize,
          'legend.fontsize' : 10,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params) 
height = 0.8

if True:
    fig1 = mp.figure()
    ax1 = fig1.add_subplot(111)
    fig1.set_size_inches(3.54,height*3.54) 
    
    for i in range(0,3):

        Ks = nKsvals[i]
        Keff = Ks*Kd_rep/(Ks+Kd_rep)

        print Keff

#        ax1.text(0.02, 0.95, '$k_{surf} = $'+Ksvals[i], transform=ax1.transAxes, fontsize=12, va='top')
        ax1.plot(Keff_rep[i][:,0],Keff_rep[i][:,1]/Keff_rep[i][0,1], '--',color = papercolors[i], linewidth = 2)
        ax1.plot(Kbc_rep[i][:,0],Kbc_rep[i][:,1]/Keff_rep[i][0,1], '-', color = papercolors[i])    
#        ax1.plot(Kbc_att[i][0:N,0],Keff*np.ones((N)), ':', color = blues[j], label = r'$k_{m}$')    
#        ax1.plot(Knum_rep[:,0],Knum_rep[:,1+i], 'o',color = blues[j], label = r'$k_N$')
        ax1.plot(Keff_rep[i][0,0], Keff_rep[i][0,1]/Keff_rep[i][0,1], color = papercolors[i], label = r'$k_{\mathrm{surf}}=$' + Ksvals[i], linewidth = 12)
    ax1.set_xscale('log')

    first_legend = mp.legend(loc = 'lower left', fontsize = legendfontsize)
    mp.gca().add_artist(first_legend)

    line = ax1.plot(Keff_rep[i][0,0],Keff_rep[i][0,1]/Keff_rep[i][0,1], 'k-', label = r'$k_{\mathrm{bc}}$')
    dashdot = ax1.plot(Keff_rep[i][0,0],Keff_rep[i][0,1]/Keff_rep[i][0,1], 'k--', linewidth = 2, label = r'$k_{\mathrm{eff}}$')
    
    handles, labels = ax1.get_legend_handles_labels()
    mp.legend(handles[3:5], labels[3:5], loc = 'upper left', fontsize = legendfontsize)

    ax1.set_xlabel('$r_d$')
    ax1.set_ylabel(r'$k_{\mathrm{tot}}/k_{r_d \rightarrow 0}$')
    ax1.set_ylim([0.78,1.3])

#    ax1.set_ylim([0.08,0.12])
#    ax1.set_yticks([0.08,0.09,0.10,0.11,0.12])

    mp.savefig('dense_rate_comparison_normalized.pdf', 
                #This is simple recomendation for publication plots
                dpi=1000, 
                # Plot will be occupy a maximum of available space
                bbox_inches='tight', 
                pad_inches=0.02
                )

if True:
    fig1 = mp.figure()
    ax1 = fig1.add_subplot(111)
    fig1.set_size_inches(3.54,height*3.54) 
    
    for i in range(0,3):

        Ks = nKsvals[i]
        Keff = Ks*Kd_rep/(Ks+Kd_rep)

        print Keff

#        ax1.text(0.02, 0.95, '$k_{surf} = $'+Ksvals[i], transform=ax1.transAxes, fontsize=12, va='top')
        ax1.plot(Keff_rep[i][:,0],Keff_rep[i][:,1], '-.',color = papercolors[i])
        ax1.plot(Kbc_rep[i][:,0],Kbc_rep[i][:,1], '-', color = papercolors[i], label = r'$k_{\mathrm{surf}}=$' + Ksvals[i])    
#        ax1.plot(Kbc_att[i][0:N,0],Keff*np.ones((N)), ':', color = blues[j], label = r'$k_{m}$')    
#        ax1.plot(Knum_rep[:,0],Knum_rep[:,1+i], 'o',color = blues[j], label = r'$k_N$')
    ax1.set_xscale('log')
    first_legend = mp.legend(loc = 'lower left', fontsize = legendfontsize)
    mp.gca().add_artist(first_legend)

    line = ax1.plot(Keff_rep[i][0,0],Keff_rep[i][0,1]/Keff_rep[i][0,1], 'k-', label = r'$k_{\mathrm{bc}}$')
    dashdot = ax1.plot(Keff_rep[i][0,0],Keff_rep[i][0,1]/Keff_rep[i][0,1], 'k-.', label = r'$k_{\mathrm{eff}}$')
    
    handles, labels = ax1.get_legend_handles_labels()
    mp.legend(handles[3:5], labels[3:5], loc = 'upper left', fontsize = legendfontsize)

    ax1.set_xlabel('$r_d$')
    ax1.set_ylabel(r'$k_{\mathrm{tot}}/k_{S}$')

#    ax1.set_ylim([0.08,0.12])
#    ax1.set_yticks([0.08,0.09,0.10,0.11,0.12])

    mp.savefig('dense_rate_comparison_absolute.pdf', 
                #This is simple recomendation for publication plots
                dpi=1000, 
                # Plot will be occupy a maximum of available space
                bbox_inches='tight', 
                pad_inches=0.02
                )

