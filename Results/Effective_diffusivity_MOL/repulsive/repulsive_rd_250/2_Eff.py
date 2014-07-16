import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as mp
from mpl_toolkits.axes_grid1 import host_subplot
import mpl_toolkits.axisartist as AA
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
rho_tmp = np.ones((resolution))

code = \
r"""
double dsum=0, dif=1, var=0;
double d_tmp[resolution];
int i, istart, j,l=0;
int k=1;
srand(time(NULL));

while(k<resolution and l<1000000){
    l+=1;
    for(i=0;i<=k;i++){
        dsum = 0;
        for(j=1;j<=i;++j){
            dsum += (r_n(j)-r_n(j-1))*exp(u_n(j))/(d_n(i)*pow(r_n(j),2));
        }
        rho_eval(i) = exp(-u_n(i))*dsum;
    }
    
    rho_eval = rho_eval/rho_eval(k-1);
    rho_tmp = rho_n/rho_n(k-1);
    var = dif;
    dif = 0;
    for(i=0;i<k;i++){
        if(rho_eval(i)<rho_tmp(i)){
            dif += fabs(rho_eval(i)-rho_tmp(i));
            d_n(i) = d_n(i)*(1-0.00001*var);
        }
        if(rho_eval(i)>rho_tmp(i)){
            dif += fabs(rho_tmp(i) - rho_eval(i));
            d_n(i) = d_n(i)*(1+0.00001*var);
        }
    }
    if(dif < 0.01){
        k+=1;
        l=0;
        d_n(k) = d_n(k-1);
    }
}
"""

inline(code, ['resolution', 'u_n', 'r_n', 'rho_n', 'kd','rho_tmp', 'rho_eval', 'd_n', 'pi'], type_converters=converters.blitz)

np.savetxt('effective_d_profile.tsv', d_n)
np.savetxt('mapped_rho.tsv', rho_eval)


