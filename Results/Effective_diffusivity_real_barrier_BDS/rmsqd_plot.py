import numpy as np
import matplotlib.pyplot as mp
import scipy.optimize as cp

def powerlaw(t,D):
    return 2.0*D*t


def powerlaw2(t,D):
    return 2.0*D*t


data = {}
edata = {}
parameters = {}
DeffShort = {}
EDeffShort = {}
DeffLong = {}
EDeffLong = {}

folders = ['rd1','rd2','rd3', 'rd4']
legendtxt = [r'$r_d = 10^{-3}$', r'$r_d = 10^{-1}$', r'$r_d = 2.5$', r'$r_d = 10^{2}$']
reds =  ['#660000', '#CC0000', '#FF3333', '#FF9999']
blues = ['', '#004C99', '#0080FF', '#66B2FF', '#CCE5FF']

Rs = 1
Rd = 20
tcut = 5
bcut = 3
i0 = 5
i1 = 10
i2 = 25
#i2 = int(np.shape(data)[0])
i3 = 33

for i, f in enumerate(folders):
    print f
    data[i] = np.loadtxt(f+'/mean_square_radius.tsv')
    edata[i] = np.loadtxt(f+'/Emean_square_radius.tsv')
    parameters[i] = np.loadtxt(f+'/rate_data01', skiprows=2)

for i, f in enumerate(folders):

    nbins = np.shape(data[i])[1]
    ntimes = np.shape(data[i])[0]
    dt = float(parameters[i][3])
    print np.shape(data[i])
    Rvals = Rs + (Rd-Rs)*np.arange(bcut,nbins-tcut-1)/float(nbins)

    DeffShort[i] = np.zeros((nbins-bcut-tcut-1))
    EDeffShort[i] = np.zeros((nbins-bcut-tcut-1))
    DeffLong[i] = np.zeros((nbins-bcut-tcut-1))
    EDeffLong[i] = np.zeros((nbins-bcut-tcut-1))



    for ibin in range(bcut,nbins-tcut-1):
        par, cov = cp.curve_fit(powerlaw2, data[i][i0:i1,-1], data[i][i0:i1,ibin], sigma =  2*edata[i][i0:i1,ibin], absolute_sigma = True)
        DeffShort[i][ibin-bcut] = par
        EDeffShort[i][ibin-bcut] = np.sqrt(cov)

    for ibin in range(bcut,nbins-tcut-1):
        par, cov = cp.curve_fit(powerlaw2,  data[i][i2:i3,-1], data[i][i2:i3,ibin], sigma = 2*edata[i][i2:i3,ibin], absolute_sigma = True)

        DeffLong[i][ibin-bcut] = par
        EDeffLong[i][ibin-bcut] = np.sqrt(cov)
       
#    DeffLong[i] = DeffLong[i]/DeffLong[i][-1]
#    EDeffLong[i] = EDeffLong[i]/DeffLong[i][-1]

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

j=1

ax1 = fig1.add_subplot(111)

print EDeffLong[0]
print np.shape(Rvals)
print np.shape(DeffLong[0])
print np.shape(DeffLong[1])
print np.shape(DeffLong[2])

ax1.text(0.05, 0.95, 'B)', transform=ax1.transAxes, fontsize=12, va='top')

for i, f in enumerate(folders):
    ax1.plot(Rvals, DeffLong[i] ,zorder = 4, color = reds[i], label = legendtxt[i])
    ax1.fill_between(Rvals, DeffLong[i] - 2*EDeffLong[i], DeffLong[i] + 2*EDeffLong[i], color = 'grey', alpha = 0.3)

ax1.set_ylabel(r'$D_{eff}/D_0$')

#ax2.set_ylim([0,0.18])

ax1.legend(loc='upper right')


mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))


mp.savefig("rDeffLong.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )


print 'plot 2'
fig2 = mp.figure()
fig2.set_size_inches(3.54,height*3.54) 

j=1

ax2 = fig2.add_subplot(111)

for i, f in enumerate(folders):
    ax2.plot(Rvals, DeffShort[i] ,zorder = 4, color = reds[i], label = legendtxt[i])
    ax2.fill_between(Rvals, DeffShort[i] - 2*EDeffShort[i], DeffShort[i] + 2*EDeffShort[i], color = 'grey', alpha = 0.3)

ax2.set_ylabel(r'$D_{eff}/D_0$')

#ax2.set_ylim([0,0.18])

ax2.legend(loc='upper right')


mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))


mp.savefig("rDeffShort.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )


