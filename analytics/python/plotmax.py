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

srates = np.arange(-1,0,0.001)
potential = range(1,10,3)
spacing_parameter = range(1,20,1)
drange = np.arange(0,10,1)
arates = np.zeros((np.shape(srates)[0],2))
kmax = np.zeros((np.shape(spacing_parameter)[0],np.shape(potential)[0],4))

space_index = -1

for k in spacing_parameter:
    space_index = space_index + 1
    spacing = np.array([1.,2.+k,4.+k])
    potential_index = -1
    for j in potential:
        potential_index = potential_index + 1
        for i in range(0,np.shape(srates)[0],1):
            u1 = np.array([0,j/4.])
            u0= np.array([0,0])
            Ku1 = calc_rate(u1,10**(srates[i]),spacing,kt,d)
            Ku0 = calc_rate(u0,10**(srates[i]),spacing,kt,d)
            arates[i,1] = Ku1/Ku0
            arates[i,0] = 10**(srates[i])

        if j != 0:
            indices = np.argmax(arates[:,1])
            print indices, spacing, j/4., arates[indices]
            kmax[space_index,potential_index,:] = [k, j/4., arates[indices,0], arates[indices,1]]


fig1 = mp.figure()
ax1 = fig1.add_subplot(111)
for i in range(np.shape(potential)[0]):
    mp.plot(kmax[:,i,0], kmax[:,i,2], label='u1 = ' + `kmax[1,i,1]`)

mp.legend(loc='upper right')
ax1.set_xlabel('a')
ax1.set_ylabel('Wres')
ax1.set_title('Resonant barrier fluct. rate for constant b-a=2')
ax1.set_xscale('log')

fig2 = mp.figure()
for i in range(np.shape(potential)[0]):
    mp.plot(kmax[:,i,0], kmax[:,i,3], label='u1 = ' + `kmax[1,i,1]`)

ax2.set_xacale('log')

mp.legend(loc='upper right')

mp.show()
