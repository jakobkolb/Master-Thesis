import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp

def powerlaw(t,D,c):
    return D*t


def powerlaw2(t,D,c):
    return 2.0*D*t+c


data = {}
parameters = {}
DeffShort = {}
DeffLong = {}
folders = ['rd025','rd25','rd250']

reds =  ['#660000', '#CC0000', '#FF3333', '#FF9999']

Rs = 1
Rd = 20
tcut = 0
bcut = 5
i0 = 1
i1 = 70
#i2 = int(np.shape(data)[0])
i2 = 300

for i, f in enumerate(folders):

    data[i] = np.loadtxt(f+'/mean_square_radius.tsv')
    parameters[i] = np.loadtxt(f+'/rate_data01', skiprows=2)

for i, f in enumerate(folders):

    nbins = np.shape(data[i])[1]
    ntimes = np.shape(data[i])[0]
    dt = float(parameters[i][3])
    times = dt*np.arange(0,ntimes)
    print np.shape(data[i])
    Rvals = np.arange(Rs,Rd,(Rd-Rs)/float(nbins))

    DeffShort[i] = np.zeros((nbins))
    DeffLong[i] = np.zeros((nbins))

    for ibin in range(bcut,nbins-tcut):
        par, cov = cp.curve_fit(powerlaw, times[i0:i1], data[i][i0:i1,ibin])
        DeffShort[i][ibin] = par[0]

    DeffShort[i] = DeffShort[i]/DeffShort[i][-1]

    for ibin in range(bcut,nbins-tcut):
        par, cov = cp.curve_fit(powerlaw2, times[i1:i2], data[i][i1:i2,ibin])
        DeffLong[i][ibin] = par[0]
       
    DeffLong[i] = DeffLong[i]/DeffLong[i][-1]

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



fig2 = mp.figure()
fig2.set_size_inches(3.54,height*3.54) 

j=1

ax2 = fig2.add_subplot(111)

print np.shape(Rvals)
print np.shape(DeffLong[0])
print np.shape(DeffLong[1])
print np.shape(DeffLong[2])

ax2.text(0.05, 0.95, 'B)', transform=ax2.transAxes, fontsize=12, va='top')
l1 = ax2.plot(Rvals, DeffLong[0], 'o', zorder = 4, color = reds[0], label = r'$r_d = 0.25$')
l2 = ax2.plot(Rvals, DeffLong[1], 'o', zorder = 4, color = reds[1], label = r'$r_d = 2.5$')
l3 = ax2.plot(Rvals, DeffLong[2], 'o', zorder = 4, color = reds[2], label = r'$r_d = 250$')

ax2.set_ylabel(r'$D_{eff}/D_0$')

#ax2.set_ylim([0,0.18])

lns = l1+l2+l3
labs = [l.get_label() for l in lns]
ax2.legend(lns, labs, loc='lower right')


mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))


mp.savefig("DeffLong.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )



fig2 = mp.figure()
fig2.set_size_inches(3.54,height*3.54) 

j=1

ax2 = fig2.add_subplot(111)

ax2.text(0.05, 0.95, 'A)', transform=ax2.transAxes, fontsize=12, va='top')
l1 = ax2.plot(Rvals, DeffShort[0], 'o' ,zorder = 4, color = reds[0], label = r'$r_d = 0.25$')
l2 = ax2.plot(Rvals, DeffShort[1], 'o' ,zorder = 4, color = reds[1], label = r'$r_d = 2.5$')
l3 = ax2.plot(Rvals, DeffShort[2], 'o' ,zorder = 4, color = reds[2], label = r'$r_d = 250$')

ax2.set_ylabel(r'$D_{eff}/D_0$')

#ax2.set_ylim([0,0.18])

lns = l1+l2+l3
labs = [l.get_label() for l in lns]
ax2.legend(lns, labs, loc='lower right')


mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))


mp.savefig("DeffShort.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )


