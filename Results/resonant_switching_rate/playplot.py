#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
import math
from scipy.optimize import curve_fit
import sympy

att_data = np.loadtxt('l_att_power_resized.data', delimiter = '\t')
rep_data = np.loadtxt('l_rep_power_resized.data', delimiter = '\t')

names = ['att', 'rep']
labels = ['B)', 'A)']

for i, kmax in enumerate([att_data,rep_data]):
    #Direct input
    mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern}"]
    #Options
    if True:
        params = {'text.usetex' : True,
                  'font.size' : 11,
                  'font.family' : 'lmodern',
                  'text.latex.unicode': True,
                  }
        mp.rcParams.update(params)

        print kmax[:,4].max()

        fig2 = mp.figure()
        

        ax0 = fig2.add_subplot(221)

        mp.plot(kmax[:,0], kmax[:,2], label=('g = %1.1f' %kmax[1,1]), color = '#aa0000')

        ax0.set_xlabel(r'$l$')
        ax0.set_ylabel(r'$r_d^{(res)}$')
        ax0.set_yscale('log')
        ax0.set_xscale('log')

        ax1 = fig2.add_subplot(222)

        mp.plot(kmax[:,0], kmax[:,4], label=('g = %1.1f' %kmax[1,1]), color = '#aa0000')

        ax1.set_xlabel(r'$l$')
        ax1.set_ylabel(r'$l/r_d^{(res)}$')
        ax1.set_yscale('log')
        ax1.set_xscale('log')
        ax1.set_ylim([0.9,20.])
        #ax1.set_xticks([0.01, 1, 100])
        #ax1.set_yticks([0.0001,0.01,1,100])
        ax1.get_xaxis().get_major_formatter().labelOnlyBase = False
        ax1.get_yaxis().get_major_formatter().labelOnlyBase = False

        ax2 = fig2.add_subplot(223)
        mp.plot(kmax[:,0], kmax[:,3], color = '#666666')

        ax2.set_xscale('log')
        ax2.set_xlabel('$l$')
        ax2.set_ylabel('$k^{(res)}/k_S$')


        ax3 = fig2.add_subplot(224)
        mp.plot(kmax[:,4], kmax[:,3], color = '#666666')

        ax3.set_xscale('log')
        ax3.set_ylim([0.8,1.4])
        #ax3.set_xlim([kmax[:,4].min(),kmax[:,4].max()])
        #ax3.set_xticks([kmax[:,4].min()+1,kmax[:,4].max()-1])
        ax3.set_xlabel('$l/r_d^{(res)}$')
        ax3.set_ylabel('$k^{(res)}/k_S$')
        ax3.text(0.05, 0.95, labels[i], transform=ax2.transAxes, fontsize=12, va='top')

        #You must select the correct size of the plot in advance
        #fig2.set_size_inches(2*3.54,3.54)

        #mp.show()

        mp.savefig('l_'+names[i] + '_power_resized.pdf',
                    #This is simple recomendation for publication plots
                    dpi=1000,
                    #Plot will be occupy a maximum of available space
                    bbox_inches='tight',
                    )  
