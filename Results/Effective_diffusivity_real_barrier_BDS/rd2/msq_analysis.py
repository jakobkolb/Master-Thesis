import numpy as np
import matplotlib.pyplot as mp
from scipy.weave import inline
from scipy.weave import converters

data = np.loadtxt('trajectories.txt')

parameters = np.loadtxt('rate_data01', skiprows=2)

nbins  = int(100)
npar = int(np.shape(data)[1])
Rs = float(1)
Rd = float(20)
ntimes = int(np.shape(data)[0])
it0max = ntimes/4
sqd = np.zeros((ntimes,nbins,2))
msqd = np.zeros((ntimes,nbins))
print np.shape(msqd)

code = \
r"""
double r, dr, rr;
int ipar, it0, it, ibin;

for(ipar =0;ipar<npar;ipar++){
    for(it0=1;it0<it0max;it0++){
        r = data(it0,ipar+1);
        ibin = (int)((r-Rs)/(Rd-Rs)*nbins);
        if(ibin>=0 and ibin<nbins){
            for(it=it0;it<ntimes;it++){
                rr = data(it,ipar+1);
                dr = (data(it0,ipar+1)-data(it,ipar+1))*(data(it0,ipar+1)-data(it,ipar+1));
                if(dr>2.0*Rd){
                    goto breakA;
                    }
                if(rr<Rs){ 
                    goto breakB;
                    }
                sqd(it,ibin,0) += (data(it0,ipar+1)-data(it,ipar+1))*(data(it0,ipar+1)-data(it,ipar+1));
                sqd(it,ibin,1) +=1;
            }
        }
    }
    breakA:;
    breakB:;
}
"""

inline(code, ['npar', 'ntimes', 'it0max', 'nbins', 'Rs', 'Rd', 'data', 'sqd'], type_converters=converters.blitz)


for ibin in range(nbins):
    for it in range(ntimes):
        if sqd[it,ibin,1] != 0:
            msqd[it,ibin] = sqd[it,ibin,0]/sqd[it,ibin,1]
        elif sqd[it,ibin,1] == 0:
            msqd[it,ibin] = float('NaN')

np.savetxt('mean_square_radius.tsv', msqd)

