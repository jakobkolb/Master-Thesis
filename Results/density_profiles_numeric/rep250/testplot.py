
import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit
import os

reds =  ['#660000', '#CC0000', '#FF3333', '#FF9999']
blues = ['#004C99', '#1299F8', '#66B2FF', '#CCE5FF']

N = 5
nbins = 1000
pi = 3.14159265359
frames  = 4
feq = 2

densdata = {}
ratedata = {}

#____________________________________#
#Import analytic data from file      #

print 'read data from files '

analytic = np.loadtxt('rhovals.tsv')


#____________________________________#
#Import measured rate data from file #

print 'read rate data from files '
for i in range(frames):
    mrate = np.loadtxt(('rate_data%02d' %(i+1)), skiprows=2)
    ratedata[i] = mrate

#____________________________________#
#Import measured dens data from file #

print 'read density data from files'
for i in range(frames):
    dens = np.loadtxt(('dens_data%02d' %(i+1)))
    densdata[i] = dens
print np.shape(densdata[1])

print 'normalize density data'
dr = densdata[0][1,0] - densdata[0][0,0]

Rates = np.zeros((frames,3))

for j in range(frames):
    particles = 0
    r = 0
    print np.shape(densdata[j])[0]
    for i in range(0,np.shape(densdata[j])[0]):
        voli = 4./3.*np.pi*((r+dr)**3-r**3)
        r = r + dr
        particles = particles + densdata[j][i,1]+densdata[j][i,3]
        densdata[j][i,1:5] =  densdata[j][i,1:5]/voli
    #print 'N = ', particles
    D = mrate[1]
    Rs = 1
    Rd = mrate[2]
    rhoinf = (Rd+Rs)/Rd*np.mean(densdata[j][-N:-1,1]+densdata[j][-N:-1,3])
    #print np.shape(densdata[j][-N:-1,1])[0]/(N-1)
    #print 'rhoinf = ', rhoinf
    Rates[j,0] = ratedata[j][6]
    print ratedata[j][6]
    Rates[j,1] = ratedata[j][12]/(4.*np.pi*D*Rs*rhoinf)
    Rates[j,2] = ratedata[j][13]/(4.*np.pi*D*Rs*rhoinf)

densdata[frames+1] = densdata[feq]
for i in range(feq,frames):
    densdata[frames+1][:,1:4] += densdata[i][:,1:4]
densdata[frames+1][:,1:4] = densdata[frames+1][:,1:4]/(frames-feq)

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
height = 0.8


print 'plot 1'
fig1 = mp.figure()
fig1.set_size_inches(3.54,height*3.54) 

ax1 = fig1.add_subplot(111)
ax1.errorbar(Rates[:,0],Rates[:,1],yerr = Rates[:,2])


mp.savefig("density_test.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
print 'plot 2'

M = 25

fig2 = mp.figure()
fig2.set_size_inches(3.54,height*3.54) 

j=1
k=0

plt = densdata[frames+1]

ax2 = fig2.add_subplot(111)
mp.yticks([0,0.04,0.08,0.12,0.16])
ax2b = ax2.twinx()
l1 = ax2.plot(densdata[frames+1][:,0],densdata[frames+1][:,1]     ,zorder = 4, color = reds[j], label = r'$\rho^{BD}_1(r)$')
ax2.fill_between(plt[:,0],plt[:,1]+2*plt[:,2],plt[:,1]-2*plt[:,2],zorder = 2, color='grey', alpha = 0.4)
l2 = ax2.plot(densdata[frames+1][:,0],densdata[frames+1][:,3]     ,zorder = 3, color = blues[j], label = r'$\rho^{BD}_2(r)$')
ax2.fill_between(plt[:,0],plt[:,3]+2*plt[:,4],plt[:,3]-2*plt[:,4],zorder = 1, color='grey', alpha = 0.4)
l3 = ax2.plot(analytic[:,0],2*np.mean(densdata[frames+1][-10:-2,1])*analytic[:,2], '--', color = reds[k], zorder = 5, label = r'$\rho^{MOL}_1(r)$')
l4 = ax2.plot(analytic[:,0],2*np.mean(densdata[frames+1][-10:-2,3])*analytic[:,1], '--', color = blues[k], zorder = 6, label = r'$\rho^{MOL}_2(r)$')
l5 = ax2b.plot(plt[:,0],plt[:,5], '--', color='grey', zorder = 0, label = '$U_1(r)$')

ax2.set_ylabel(r'$\rho_n(r)$')
ax2b.set_ylabel(r'$U_m$')

ax2.set_ylim([0,0.18])

lns = l1+l2+l3+l4+l5
labs = [l.get_label() for l in lns]
ax2.legend(lns, labs, loc='lower right')


mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))


mp.savefig("mdensity_test.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
