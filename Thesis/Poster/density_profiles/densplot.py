#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp

list_of_files = range(1,3,1)

dens1 = np.loadtxt('table1.tsv')
dens2 = np.loadtxt('table2.tsv')
dens3 = np.loadtxt('table3.tsv')


fig = mp.figure()

ax1 = fig.add_subplot(311)
ax1.text(0.05, 0.95, 'A)', transform=ax1.transAxes, fontsize=16, va='top')
mp.plot(dens1[:,0], dens1[:,1], 'r--')
mp.plot(dens1[:,0], dens1[:,2], 'b-.')
ax1.set_ylim([0,1.41])
mp.yticks([0,0.7,1.4])
ax1.set_ylabel(r'$\rho_n(r)$')

ax2 = fig.add_subplot(312)
ax2.text(0.05, 0.95, 'B)', transform=ax2.transAxes, fontsize=16, va='top')
mp.plot(dens2[:,0], dens2[:,1], 'r--')
mp.plot(dens2[:,0], dens2[:,2], 'b-.')
ax2.set_ylim([0,1.41])
mp.yticks([0,0.7,1.4])
ax2.set_ylabel(r'$\rho_n(r)$')

ax3 = fig.add_subplot(313)
ax3.text(0.05, 0.95, 'C)', transform=ax3.transAxes, fontsize=16, va='top')
p30 = mp.plot(dens3[:,0], dens3[:,1], 'r--', label = r'$\rho_0(r)$')
p31 = mp.plot(dens3[:,0], dens3[:,2], 'b-.', label = r'$\rho_1(r)$')
ax3.set_ylim([0,1.41])
mp.yticks([0,0.7,1.4])
ax3.set_xlabel(r'$r$')
ax3.set_ylabel(r'$\rho_n(r)$')


lns = p30 + p31
labs = [l.get_label() for l in lns]
ax1.legend(lns, labs, loc='lower right')
ax2.legend(lns, labs, loc='lower right')
ax3.legend(lns, labs, loc='lower right')





mp.show()
