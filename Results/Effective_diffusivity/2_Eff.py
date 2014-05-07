import numpy as np
import matplotlib.pyplot as mp
from scipy.weave import inline
from scipy.weave import converters
data = np.loadtxt('rhovals.tsv')
r_n = data[:,0]
rho_n = data[:,1]
u_n = data[:,2]
kd=1
pi = np.pi

resolution = np.shape(data)[0]
print resolution
d_n = np.ones((resolution))
rho_eval = np.zeros((resolution))

code = \
r"""
double dsum=0, dif=1, var=0;
int i,j;
while(dif > 0.1){

    for(i=0;i<resolution;i++){
        dsum = 0;
        for(j=1;j<=i;++j){
            dsum += (r_n(j)-r_n(j-1))*exp(u_n(j))/(d_n(i)*pow(r_n(j),2));
        }
        rho_eval(i) = exp(-u_n(i))*dsum;
    }

    rho_eval = rho_eval/rho_eval(resolution-1);

    printf("repeat");
    var = dif;
    dif = 0;
    for(i=1;i<resolution;i++){
        if(rho_eval(i)<rho_n(i)){
            dif += fabs(rho_eval(i)-rho_n(i));
            d_n(i) = d_n(i)*(1-0.0001*var);
        }
        if(rho_eval(i)>rho_n(i)){
            dif += fabs(rho_n(i) - rho_eval(i));
            d_n(i) = d_n(i)*(1+0.0001*var);
        }
    }
    printf("%g \n", dif);
}
"""

inline(code, ['resolution', 'u_n', 'r_n', 'rho_n', 'kd', 'rho_eval', 'd_n', 'pi'], type_converters=converters.blitz)

#for i in range(resolution-1):
#    dsum = 0
#    for j in range(i-1):
#        dsum += (r_n[j+1]-r_n[j])*np.exp(u_n[j])/(d_n[j]*r_n[j]**2)
#    rho_eval[i]=kd/(4*np.pi)*np.exp(-u_n[i])*dsum
#    print i
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

fig2 = mp.figure()
ax2 = fig2.add_subplot(111)
mp.plot(r_n, rho_eval, label = 'mapping')
mp.plot(r_n, rho_n, label = 'measured')
mp.plot(r_n, u_n, label = 'potential')

mp.savefig("reverse_dens.pdf",
        #This is simple recomendation for publication plots
        dpi=1000,
        # Plot will be occupy a maximum of available space
        bbox_inches='tight',
        )


fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
mp.plot(r_n, d_n, label = 'effective diffusivity')
mp.plot(r_n, np.ones((resolution)), label = 'bulk diffusivity')

mp.legend(loc='upper left')

mp.savefig("effective_diffusivity.pdf",
        #This is simple recomendation for publication plots
        dpi=1000,
        # Plot will be occupy a maximum of available space
        bbox_inches='tight',
        )


