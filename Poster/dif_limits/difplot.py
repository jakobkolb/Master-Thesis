import numpy as np
import matplotlib.pyplot as mp

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

#You must select the correct size of the plot in advance
fig.set_size_inches(3.54,5.54) 

def lim0(a,b,u):
    lim0 = (b-b*np.exp(u)+a*(-1-2*b+np.exp(u)))/(2*(b-b*np.exp(u)+a*(-1-b+np.exp(u))))
    return lim0

def liminf(a,b,u):
    liminf = (a*b*(3+np.exp(u)))/(2*b*(-1+np.exp(u))+a*(2-2*np.exp(u)+b*(3+np.exp(u))))
    return liminf

uvalues1 = np.arange(-10,10,0.1)
tvalues1 = np.arange(0.1,3,0.5)
g   = 1
rs  = 1
ax1 = fig.add_subplot(211)
ax1.text(0.05, 0.95, 'A)', transform=ax1.transAxes, fontsize=16, va='top')
for t in tvalues1:
    a = rs + t
    b = rs + (1+g)*t
    mp.plot(uvalues1, liminf(a,b,uvalues1)-lim0(a,b,uvalues1), label=('t = %1.1f' %t))
ax1.set_ylim(-0.02,0.5)
ax1.legend(loc='upper left')
ax1.set_xlabel(r'$U_1/K_B T$')
ax1.set_ylabel(r'$K^{(\infty)}-K^{(0)}$')

uvalues2 = [0,1,2,3,4,5]
tvalues2 = np.arange(-7,5,0.01)
ax2 = fig.add_subplot(212)
ax2.text(0.05, 0.95, 'B)', transform=ax2.transAxes, fontsize=16, va='top')
for u in uvalues2:
    av = rs + 10**tvalues2
    bv = rs + (1+g)*10**tvalues2
    mp.plot(10**tvalues2, liminf(av,bv,u) - lim0(av,bv,u), label=('u=%1.0f'%u))

ax2.set_xscale('log')
ax2.set_xticks([0.000001,0.0001,0.01,1,100,10000])
ax2.set_yticks([0,0.1,0.2,0.3,0.4])
ax2.get_xaxis().get_major_formatter().labelOnlyBase = False
ax2.legend(loc='upper left')
ax2.set_xlabel(r'$t$')
ax2.set_ylabel(r'$K^{(\infty)}-K^{(0)}$')

mp.savefig("density_profiles.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            )
