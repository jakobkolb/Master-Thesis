import numpy as np
import matplotlib.pyplot as mp
from scipy.weave import inline
from scipy.weave import converters
#define C code and theta function
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
        rho_eval(i) = kd/(4.0*pi)*exp(-u_n(i))*dsum;
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
        if(k<resolution){
            d_n(k) = d_n(k-1);
        }
    }
}
"""

def theta(x):
    return 0.5*(np.sign(x)+1)

#set parameters
kd=1
d = 1.
a = 6.
b = 11.
Ua = -3.
Ur = 3.
Uma = -1.5
Umr = 1.5
rd = [250,2.5,0.25]
rdfolder = ['1','2','3','4']
l = a-1.
g = (b-a)/l
pi = np.pi
modi = ['repulsive', 'attractive']

#define dictionaries for density data
att_dens = {}
rep_dens = {}

#load spacing
tmp = np.loadtxt('attractive/att1/rhovals.tsv')
r_n = tmp[:,0]
resolution = np.shape(r_n)[0]
print r_n
#load repulsive data and potential
for i in range(3):
    tmp = np.loadtxt('repulsive/rep'+rdfolder[i]+'/rhovals.tsv')
    rep_dens[`i`] = tmp[:,1]
    u_rep = tmp[:,2]

#load attractive data and potential
for i in range(3):
    tmp = np.loadtxt('attractive/att'+rdfolder[i]+'/rhovals.tsv')
    att_dens[`i`] = tmp[:,1]
    u_att = tmp[:,2]

print 'now the hart part starts'
for mod in modi:
    for i in range(3):
        print mod, i, 'start mapping'
        if mod == 'repulsive':
            rho_n = rep_dens[`i`][:]
            d_n = np.ones((resolution))
            rho_eval = np.zeros((resolution))
            rho_tmp = np.ones((resolution))
            u_n = u_rep
        if mod == 'attractive':
            rho_n = att_dens[`i`][:]
            d_n = np.ones((resolution))
            rho_eval = np.zeros((resolution))
            rho_tmp = np.ones((resolution))
            u_n = u_att

        inline(code, ['resolution', 'u_n', 'r_n', 'rho_n', 'kd','rho_tmp', 'rho_eval', 'd_n', 'pi'], type_converters=converters.blitz)
#generate output of r,rho_analytic,rho_mapped,d_effective, u_m
        print 'save output'
        output = np.zeros((resolution,5))
        output[:,0] = r_n
        output[:,1] = rho_n
        output[:,2] = rho_eval
        output[:,3] = d_n
        output[:,4] = u_n
        np.savetxt('mapping_output/'+mod+'_'+`i`+'.tsv', output)


