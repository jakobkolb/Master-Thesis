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
    det = np.linalg.det(bc_matrix[0:11,0:11])
    k = 4.*np.pi*d*spacing[0]**2*sum(np.dot(s,rhodash(spacing[0],eig,d)).dot(np.transpose(c[0:4])))/sum(np.dot(s,rho(spacing[3],eig,d)).dot(np.transpose(c[8:12])))
    return k, det

def k0(rs,a,b,rd,u,kt):
    return (1-rs/rd)/(rs*(np.exp(u/kt)-1)*(1/a-1/b)+1-rs/rd)

srates = range(-25,15,1)
potential = np.arange(-2,-1,1)
print potential
spacing_parameter = range(0,19,1)
arates = np.zeros((np.shape(srates)[0],3))

kmax = np.zeros((np.shape(potential)[0],np.shape(spacing_parameter)[0]))

fig1 = mp.figure()
ax = fig1.add_subplot(111)

for k in spacing_parameter:
    spacing = np.array([1.,1.+k/10.,20.,20.])
    for j in potential:
        for i in range(0,np.shape(srates)[0],1):
            u1 = np.array([0,4.])
            u0= np.array([0,0])
            Ku1, det = calc_rate(u1,10**(srates[i]/5.),spacing,kt,d)
            Ku0, tmp = calc_rate(u0,10**(srates[i]/5.),spacing,kt,d)
            arates[i,1] = Ku1/Ku0
            arates[i,0] = 10**(srates[i]/5.)
            arates[i,2] = det
        mp.plot(arates[:,0], arates[:,1], label='a = ' + `spacing[1]`)
        #mp.plot(arates[:,0], np.ones((np.shape(arates)[0]))*k0(spacing[0],spacing[1],spacing[2],spacing[3],u1[1]/2.,1.))
        #mp.plot(arates[:,0], np.ones((np.shape(arates)[0]))*(k0(spacing[0],spacing[1],spacing[2],spacing[3],u1[1],1.)/2.+1/2.))
    ax.set_title('Rs = ' + `spacing[0]` + ', U1 = %1.1f, a = %1.1f, b = %1.1f' % (u1[1], spacing[1],spacing[2]))
    ax.set_xscale('log')
    mp.grid()
    #mp.legend(loc='lower left')
    #ax.set_ylim([1,2])
    ax.set_xlabel('switching rate')
    ax.set_ylabel('reaction rate/debye rate')
   #fig2 = mp.figure()
   #ax2 = fig2.add_subplot(111)
   #mp.plot(arates[:,0], arates[:,2], label='a = ' + `spacing[1]`)
   #ax2.set_xscale('log')
   #ax2.set_yscale('log')
   #ax2.set_xlabel('switching rate')
   #ax2.set_ylabel('determinant of fit matrix')

    mp.grid()
mp.show()
