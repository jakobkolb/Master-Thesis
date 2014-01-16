#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

kt = 1.
d = 1.
def rho(r,eig,d):
    rho = np.array([[1.,1./r,0,0],[0,0,np.exp(-np.sqrt(abs(eig[1])/d)*r)/r,np.exp(np.sqrt(abs(eig[1])/d)*r)/r]])
    return rho

def rhodash(r,eig,d):
    rhodash = np.array([[0,-1./r**2,0,0],[0,0, -np.sqrt(abs(eig[1])/d)*np.exp(-np.sqrt(abs(eig[1])/d)*r)/r-np.exp(-np.sqrt(abs(eig[1])/d)*r)/r**2, np.sqrt(abs(eig[1])/d)*np.exp(np.sqrt(abs(eig[1])/d)*r)/r-np.exp(np.sqrt(abs(eig[1])/d)*r)/r**2]])
    return rhodash

def calc_rate(u,rate,spacing,kt,d):

    w = np.array([[-rate,rate],[rate,-rate]])

    (eig,s) = np.linalg.eig(w)
    s[0:2,0] = s[0:2,0]/np.linalg.norm(s[0:2,0])
    s[0:2,1] = s[0:2,1]/np.linalg.norm(s[0:2,1])

    invs = np.linalg.inv(s)

    expu = np.diag(np.exp(u/kt))

    lgsdim = np.shape(eig)[0]*np.shape(spacing)[0]*2

    bc_matrix = np.zeros((12,12))
    bc_matrix[0:2,0:4] = rho(spacing[0],eig,d)
    bc_matrix[2:4,0:8] = np.concatenate((rho(spacing[1],eig,d),-np.dot(invs,expu).dot(s).dot(rho(spacing[1],eig,d))),1)
    bc_matrix[4:6,0:8] = np.concatenate((rhodash(spacing[1],eig,d),-rhodash(spacing[1],eig,d)),1)
    bc_matrix[6:8,4:12] = np.concatenate((-np.dot(invs,expu).dot(s).dot(rho(spacing[2],eig,d)),rho(spacing[2],eig,d)),1)
    bc_matrix[8:10,4:12] = np.concatenate((rhodash(spacing[2],eig,d),-rhodash(spacing[2],eig,d)),1)
    bc_matrix[10:12,8:12] = np.array([[1,0,0,0],[0,0,0,0]])
    #print np.linalg.det(bc_matrix[0:11,0:11])
    b = np.zeros((12))
    b[10] = 1
    c = np.linalg.solve(bc_matrix[0:11,0:11],np.transpose(b[0:11]))
    c = np.concatenate((c[0:11],[0]))

    k = 4.*np.pi*d*spacing[0]**2*sum(np.dot(s,rhodash(spacing[0],eig,d)).dot(np.transpose(c[0:4])))
    return k


srates = range(-25,15,1)
potential = range(0,10,1)
spacing_parameter = range(1,6,1)
arates = np.zeros((np.shape(srates)[0],2))

kmax = np.zeros((np.shape(potential)[0],np.shape(spacing_parameter)[0]))

for k in spacing_parameter:
    fig = mp.figure()
    ax = fig.add_subplot(111)
    spacing = np.array([1.,2.*k,2+2.*k])
    for j in potential:
        for i in range(0,np.shape(srates)[0],1):
            u1 = np.array([0,j/4.])
            u0= np.array([0,0])
            Ku1 = calc_rate(u1,10**(srates[i]/5.),spacing,kt,d)
            Ku0 = calc_rate(u0,10**(srates[i]/5.),spacing,kt,d)
            arates[i,1] = Ku1/Ku0
            arates[i,0] = 10**(srates[i]/5.)

        mp.plot(arates[:,0], arates[:,1], label='u1 = ' + `j/4.`)

    ax.set_title('Rs = ' + `spacing[0]` + ', a = ' + `spacing[1]` + ', b = ' + `spacing[2]`)
    ax.set_xscale('log')
    mp.legend(loc='upper left')
   # ax.set_ylim([1,2])
    ax.set_xlabel('switching rate')
    ax.set_ylabel('reaction rate')
    mp.grid()

mp.show()
