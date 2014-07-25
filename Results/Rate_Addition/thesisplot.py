import numpy as np
import matplotlib.pyplot as mp

reds =  ['#660000', '#CC0000', '#FF3333', '#FF9999']
blues = ['#004C99', '#0080FF', '#66B2FF', '#CCE5FF']

Keff_att = {}
Keff_rep = {}
Kbc_att = {}
Kbc_rep = {}
Knum_att = {}
Knum_rep = {}

Ksvals = ['0.1','1','10']

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
    

Knum_tmp_att = np.loadtxt('att_numeric_rates.csv', delimiter=',')
Knum_tmp_rep = np.loadtxt('rep_numeric_rates.csv', delimiter=',')

print np.shape(Knum_tmp_att)

N_tmp_att = np.zeros((np.shape(Knum_tmp_att)[0],2))
N_tmp_rep = np.zeros((np.shape(Knum_tmp_rep)[0],2))
print np.shape(N_tmp_att)

fig1 = mp.figure()
ax1 = fig1.add_subplot(111)

for i, k in enumerate(Ksvals):
    N_tmp_att[:,0] = Knum_tmp_att[:,0]
    N_tmp_att[:,1] = Knum_tmp_att[:,i+1]
    N_tmp_rep[:,0] = Knum_tmp_rep[:,0]
    N_tmp_rep[:,1] = Knum_tmp_rep[:,i+1]
    Knum_att[i] = N_tmp_att
    Knum_rep[i] = N_tmp_rep
    ax1.plot(Knum_rep[i][:,0],Knum_rep[i][:,1], 'o', label = r'$K_s = $'+k)

ax1.set_xscale('log')

mp.legend()

#Direct input 
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern, MnSymbol}"]
#Options
params = {'text.usetex' : True,
          'font.size' : 10,
          'legend.fontsize' : 10,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params) 
height = 0.8


fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
fig1.set_size_inches(3.54,height*3.54) 

i = 0

ax1.text(0.02, 0.95, '$K_s = $'+Ksvals[i], transform=ax1.transAxes, fontsize=12, va='top')
ax1.plot(Keff_rep[i][:,0],Keff_rep[i][:,1], '-',color = reds[i], label = r'$K_{eff}$')
ax1.plot(Kbc_rep[i][:,0],Kbc_rep[i][:,1], '-.', color = reds[i], label = r'$K_{bc}$')    
ax1.plot(Knum_rep[i][:,0],Knum_rep[i][:,1], 'o',color = blues[i], label = r'$K_N$')
ax1.set_xscale('log')
ax1.set_xlabel('$r_d$')
ax1.set_ylabel('$K/K_D$')

mp.legend()

mp.savefig('rate_comparison'+`i`+'.pdf', 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )


fig2 = mp.figure()
ax2 = fig2.add_subplot(111)
fig2.set_size_inches(3.54,height*3.54) 

i = 1

ax2.text(0.02, 0.95, '$K_s = $'+Ksvals[i], transform=ax2.transAxes, fontsize=12, va='top')
ax2.plot(Keff_rep[i][:,0],Keff_rep[i][:,1], '-',color = reds[i], label = r'$K_{eff}$')
ax2.plot(Kbc_rep[i][:,0],Kbc_rep[i][:,1], '-.', color = reds[i], label = r'$K_{bc}$')   
ax2.plot(Knum_rep[i][:,0],Knum_rep[i][:,1], 'o',color = blues[i],  label = r'$K_N$')
ax2.set_xscale('log')
mp.legend()
ax2.set_xlabel('$r_d$')
ax2.set_ylabel('$K/K_D$')

mp.savefig('rate_comparison'+`i`+'.pdf', 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )


fig3 = mp.figure()
ax3 = fig3.add_subplot(111)
fig3.set_size_inches(3.54,height*3.54) 

i = 2

ax3.text(0.02, 0.95, '$K_s = $'+Ksvals[i], transform=ax3.transAxes, fontsize=12, va='top')
ax3.plot(Keff_rep[i][:,0],Keff_rep[i][:,1], '-',color = reds[i], label = r'$K_{eff}$')
ax3.plot(Kbc_rep[i][:,0],Kbc_rep[i][:,1], '-.', color = reds[i], label = r'$K_{bc}$')   
ax3.plot(Knum_rep[i][:,0],Knum_rep[i][:,1], 'o',color = blues[i], label = r'$K_N$')
ax3.set_xscale('log')
mp.legend()
ax3.set_xlabel('$r_d$')
ax3.set_ylabel('$K/K_D$')

mp.savefig('rate_comparison'+`i`+'.pdf', 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
    
