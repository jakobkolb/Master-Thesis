import numpy as np
import os

spacing = [1,6,11,20]
x = [0.04,0.4,4]
rates = np.zeros((np.shape(x)[0]))
for i in range(np.shape(x)[0]):
    rates[i] = 0.5*x[i]*x[i]
flow = np.zeros((np.shape(spacing)[0],3))

data = {}
for i, dataset in enumerate(os.listdir('data/')):
    data[dataset] = np.loadtxt('data/'+dataset)
    print np.shape(data[dataset])
    k = 0
    ri=0
    for j, r in enumerate(spacing):
        print j
        while(ri<r):
            ri = data[dataset][k,0]
            k += 1
        if j == 0:
            rho11, rho12 = data[dataset][k-1,1], data[dataset][k,1]
            rho21, rho22 = data[dataset][k-1,2], data[dataset][k,2]
        if j > 0:
            rho11, rho12 = data[dataset][k-2,1], data[dataset][k-1,1]
            rho21, rho22 = data[dataset][k-2,2], data[dataset][k-1,2]
            print rho11, rho12
            print rho21, rho22
            print ri, k, j
        flow[j,0] = 4*np.pi*rates[i] 
