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
<<<<<<< HEAD
sqd = np.zeros((ntimes,nbins,4))
msqd = np.zeros((ntimes,nbins+1,2))
print np.shape(data)
=======
sqd = np.zeros((ntimes,nbins,2))
msqd = np.zeros((ntimes,nbins))
>>>>>>> 9cdd54589e7c3ef1f5632549fa4c04677abcdfb6
print np.shape(msqd)

code = \
r"""
double r, dr, rr;
int ipar, it0, it, ibin;

<<<<<<< HEAD
printf("mean \n");

for(ipar =1;ipar<npar+1;ipar++){
        it0=0;
        r = data(it0,ipar);
        ibin = (int)((r-Rs)/(Rd-Rs)*nbins);
        if(ibin>=0 and ibin<nbins){
            for(it=it0;it<ntimes;it++){
                rr = data(it,ipar);
                dr = (data(it0,ipar)-data(it,ipar))*(data(it0,ipar)-data(it,ipar));
=======
for(ipar =0;ipar<npar;ipar++){
    for(it0=1;it0<it0max;it0++){
        r = data(it0,ipar+1);
        ibin = (int)((r-Rs)/(Rd-Rs)*nbins);
        if(ibin>=0 and ibin<nbins){
            for(it=it0;it<ntimes;it++){
                rr = data(it,ipar+1);
                dr = (data(it0,ipar+1)-data(it,ipar+1))*(data(it0,ipar+1)-data(it,ipar+1));
>>>>>>> 9cdd54589e7c3ef1f5632549fa4c04677abcdfb6
                if(dr>2.0*Rd){
                    goto breakA;
                    }
                if(rr<Rs){ 
                    goto breakB;
                    }
<<<<<<< HEAD
                sqd(it,ibin,0) += dr;
                sqd(it,ibin,1) +=1.0;
            }
=======
                sqd(it,ibin,0) += (data(it0,ipar+1)-data(it,ipar+1))*(data(it0,ipar+1)-data(it,ipar+1));
                sqd(it,ibin,1) +=1;
            }
        }
>>>>>>> 9cdd54589e7c3ef1f5632549fa4c04677abcdfb6
    }
    breakA:;
    breakB:;
}
<<<<<<< HEAD

printf("variance \n");

for(ipar =1;ipar<npar+1;ipar++){
        it0=0;
        r = data(it0,ipar);
        ibin = (int)((r-Rs)/(Rd-Rs)*nbins);
        if(ibin>=0 and ibin<nbins){
            for(it=it0;it<ntimes;it++){
                rr = data(it,ipar);
                dr = (data(it0,ipar)-data(it,ipar))*(data(it0,ipar)-data(it,ipar));
                if(dr>2.0*Rd){
                    goto breakC;
                    }
                if(rr<Rs){ 
                    goto breakD;
                    }
                sqd(it,ibin,2) += (dr-sqd(it,ibin,0)/sqd(it,ibin,1))*(dr-sqd(it,ibin,0)/sqd(it,ibin,1));
                sqd(it,ibin,3) +=1.0;
            }
    }
    breakC:;
    breakD:;
}


=======
>>>>>>> 9cdd54589e7c3ef1f5632549fa4c04677abcdfb6
"""

inline(code, ['npar', 'ntimes', 'it0max', 'nbins', 'Rs', 'Rd', 'data', 'sqd'], type_converters=converters.blitz)


for ibin in range(nbins):
    for it in range(ntimes):
        if sqd[it,ibin,1] != 0:
<<<<<<< HEAD
            msqd[it,ibin,0] = sqd[it,ibin,0]/sqd[it,ibin,1]
        elif sqd[it,ibin,1] == 0:
            msqd[it,ibin,0] = 0
        
        if sqd[it,ibin,3] != 0:
            msqd[it,ibin,1] = sqd[it,ibin,2]/sqd[it,ibin,3]/np.sqrt(sqd[it,ibin,3])
        elif sqd[it,ibin,3] == 0:
            msqd[it,ibin,1] = 0
msqd[:,-1,0] = data[:,0]
msqd[:,-1,1] = data[:,0]

np.savetxt('mean_square_radius.tsv', msqd[:,:,0])
np.savetxt('Emean_square_radius.tsv', msqd[:,:,1])
=======
            msqd[it,ibin] = sqd[it,ibin,0]/sqd[it,ibin,1]
        elif sqd[it,ibin,1] == 0:
            msqd[it,ibin] = float('NaN')

np.savetxt('mean_square_radius.tsv', msqd)
>>>>>>> 9cdd54589e7c3ef1f5632549fa4c04677abcdfb6

