#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from mpl_toolkits.axes_grid1 import host_subplot
from rate import *
from scipy.optimize import curve_fit
import sympy

reds =  ['', '#660000', '#CC0000', '#FF3333', '#FF9999']
blues = ['', '#004C99', '#0080FF', '#66B2FF', '#CCE5FF']

#define dictionaries for data in format r, rho_analytic, rho_mapped, d_effective
rep_data = {}
att_data = {}
for i in range(4):
    rep_data[i] = np.loadtxt('mapping_output/repulsive_'+`i`+'.tsv')
    att_data[i] = np.loadtxt('mapping_output/attractive_'+`i`+'.tsv')

#Direct input 
mp.rcParams['text.latex.preamble']=[r"\usepackage{lmodern, MnSymbol}"]
#Options
params = {'text.usetex' : True,
          'font.size' : 10,
          'legend.fontsize' : 10,
          'font.family' : 'lmodern',
          'text.latex.unicode': True,
          }
mp.rcParams.update(params) 
height = 0.8
if True:
    print 'plot 1'
    fig1 = mp.figure()
    fig1.set_size_inches(3.54,height*3.54) 

    ax1 = fig1.add_subplot(111)
    ax1b = ax1.twinx()
    l1 = ax1.plot(rep_data[0][1:-1,0], rep_data[0][1:-1,3], zorder = 4, color = reds[1], label = r'$r_d = 10^{-3}$')
    l2 = ax1.plot(rep_data[1][1:-1,0], rep_data[1][1:-1,3], zorder = 3, color = reds[2], label = r'$r_d = 10^{-1}$')
    l3 = ax1.plot(rep_data[2][1:-1,0], rep_data[2][1:-1,3], zorder = 2, color = reds[3], label = r'$r_d = 2.5$')
    l4 = ax1.plot(rep_data[2][1:-1,0], rep_data[3][1:-1,3], zorder = 1, color = reds[4], label = r'$r_d = 10^{2}$')

    ax1.text(0.02, 0.95, 'A)', zorder = 5, transform=ax1.transAxes, fontsize=12, va='top')
    l5 = ax1b.plot(rep_data[0][:,0], rep_data[0][:,4], '--', zorder = 6, color = '#A0A0A0', label = r'$U_m(r)$')

    ax1.set_ylim([0,1.3])
    ax1.set_yticks([0,0.6,1.2])
    ax1.set_xlim([0,20])
    ax1.set_ylabel(r'$D_{eff}$')

    ax1b.set_ylabel(r'$U_m$')
    ax1b.set_yticks([0,0.5,1.0,1.5])

    lns = l1+l2+l3+l4+l5
    labs = [l.get_label() for l in lns]
    ax1.legend(lns, labs, loc='lower right')

    mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))

    ax1.tick_params(\
            axis='x',          # changes apply to the x-axis
            which='both',      # both major and minor ticks are affected
            bottom='off',      # ticks along the bottom edge are off
            top='off')         # ticks along the top edge are off

    ax1.set_zorder(ax1b.get_zorder()+1)
    ax1.patch.set_visible(False)


    mp.savefig("repulsive_mapping_d.pdf", 
                #This is simple recomendation for publication plots
                dpi=1000, 
                # Plot will be occupy a maximum of available space
                bbox_inches='tight', 
                pad_inches=0.02
                )
    print 'plot 2'
    fig2 = mp.figure()
    #You must select the correct size of the plot in advance
    fig2.set_size_inches(3.54,height*3.54) 
    ax2 = fig2.add_subplot(111)
    ax2b = ax2.twinx()

    l1 = ax2.plot(rep_data[0][1:-1,0], rep_data[0][1:-1,1], zorder = 2, color = blues[1], label = r'$r_d = 10^{-3}$')
    l2 = ax2.plot(rep_data[1][1:-1,0], rep_data[1][1:-1,1], zorder = 3, color = blues[2], label = r'$r_d = 10^{-1}$')
    l3 = ax2.plot(rep_data[2][1:-1,0], rep_data[2][1:-1,1], zorder = 4, color = blues[3], label = r'$r_d = 2.5$')
    l4 = ax2.plot(rep_data[2][1:-1,0], rep_data[3][1:-1,1], zorder = 5, color = blues[4], label = r'$r_d = 10^{2}$')

    ax2.text(0.02, 0.95, 'B)', zorder = 6, transform=ax2.transAxes, fontsize=12, va='top')
    l5 = ax2b.plot(rep_data[0][:,0], rep_data[0][:,4], '--', zorder = 7, color = '#A0A0A0', label = r'$U_m(r)$')

    ax2.set_zorder(ax2b.get_zorder()+1)
    ax2.patch.set_visible(False)

    ax2.set_ylim([0,1.1])
    ax2.set_yticks([0,0.5,1])
    ax2.set_xlim([0,20])
    ax2.set_ylabel(r'$\rho_{m}$')

    ax2b.set_ylabel(r'$U_m$')
    ax2b.set_yticks([0,0.5,1.0,1.5])
    mp.xticks([1,6,11])

    lns = l1+l2+l3+l4+l5
    labs = [l.get_label() for l in lns]
    ax2.legend(lns, labs, loc='lower right')

    mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))

    ax2.tick_params(\
            axis='x',          # changes apply to the x-axis
            which='both',      # both major and minor ticks are affected
            bottom='off',      # ticks along the bottom edge are off
            top='off')         # ticks along the top edge are off

    lns = l1+l2+l3+l4
    labs = [l.get_label() for l in lns]
    ax2.legend(lns, labs, loc='lower right')


    mp.savefig("repulsive_mapping_densities.pdf", 
                #This is simple recomendation for publication plots
                dpi=1000, 
                # Plot will be occupy a maximum of available space
                bbox_inches='tight', 
                pad_inches=0.02
                ) 
if True:
    print 'plot 3'
    fig3 = mp.figure()
    fig3.set_size_inches(3.54,height*3.54) 

    ax3 = fig3.add_subplot(111)
    ax3b = ax3.twinx()
    l1 = ax3.plot(att_data[0][1:-1,0], att_data[0][1:-1,3], zorder = 4, color =reds[1], label = r'$r_d = 10^{-3}$')
    l2 = ax3.plot(att_data[1][1:-1,0], att_data[1][1:-1,3], zorder = 3, color =reds[2], label = r'$r_d = 10^{-1}$')
    l3 = ax3.plot(att_data[2][1:-1,0], att_data[2][1:-1,3], zorder = 2, color = reds[3], label = r'$r_d = 2.5$')
    l4 = ax3.plot(att_data[2][1:-1,0], att_data[3][1:-1,3], zorder = 1, color = reds[4], label = r'$r_d = 10^{2}$')

    ax3.text(0.02, 0.95, 'A)', zorder = 5, transform=ax3.transAxes, fontsize=12, va='top')
    l5 = ax3b.plot(att_data[0][:,0], att_data[0][:,4], '--', zorder = 6, color = '#A0A0A0', label = r'$U_m(r)$')

    ax3.set_ylim([0,2])
    ax3.set_yticks([0,1,2])
    ax3.set_xlim([0,20])
    ax3.set_ylabel(r'$D_{eff}$')

    ax3b.set_ylabel(r'$U_m$')
    ax3b.set_yticks([0,-0.5,-1.0,-1.5])

    lns = l1+l2+l3+l4+l5
    labs = [l.get_label() for l in lns]
    ax3.legend(lns, labs, loc='lower right')

    mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))

    ax3.tick_params(\
            axis='x',          # changes apply to the x-axis
            which='both',      # both major and minor ticks are affected
            bottom='off',      # ticks along the bottom edge are off
            top='off')         # ticks along the top edge are off

    ax3.set_zorder(ax3b.get_zorder()+1)
    ax3.patch.set_visible(False)


    mp.savefig("attractive_mapping_d.pdf", 
                #This is simple recomendation for publication plots
                dpi=1000, 
                # Plot will be occupy a maximum of available space
                bbox_inches='tight', 
                pad_inches=0.02
                )
    print 'plot 4'
    fig4 = mp.figure()
    #You must select the correct size of the plot in advance
    fig4.set_size_inches(3.54,height*3.54) 
    ax4 = fig4.add_subplot(111)
    ax4b = ax4.twinx()

    l1 = ax4.plot(att_data[0][1:-1,0], att_data[0][1:-1,1], zorder = 1, color =blues[1], label = r'$r_d = 10^{-3}$')
    l2 = ax4.plot(att_data[1][1:-1,0], att_data[1][1:-1,1], zorder = 2, color =blues[2], label = r'$r_d = 10^{-1}$')
    l3 = ax4.plot(att_data[2][1:-1,0], att_data[2][1:-1,1], zorder = 3, color = blues[3], label = r'$r_d = 2.5$')
    l4 = ax4.plot(att_data[2][1:-1,0], att_data[3][1:-1,1], zorder = 4, color = blues[4], label = r'$r_d = 10^{2}$')

    ax4.text(0.02, 0.95, 'B)', zorder = 5, transform=ax4.transAxes, fontsize=12, va='top')
    l5 = ax4b.plot(att_data[0][:,0], att_data[0][:,4], '--', zorder = 6, color = '#A0A0A0', label = r'$U_m(r)$')

    ax4.set_zorder(ax4b.get_zorder()+1)
    ax4.patch.set_visible(False)

    #ax4.set_ylim([0,2])
    #ax4.set_yticks([0,1,2])
    ax4.set_xlim([0,20])
    ax4.set_ylabel(r'$\rho_{m}$')

    ax4b.set_ylabel(r'$U_m$')
    ax4b.set_yticks([0,-0.5,-1.0,-1.5])
    mp.xticks([1,6,11])

    lns = l1+l2+l3+l4+l5
    labs = [l.get_label() for l in lns]
    ax4.legend(lns, labs, loc='lower right')

    mp.xticks((1,6,11,19),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))

    ax4.tick_params(\
            axis='x',          # changes apply to the x-axis
            which='both',      # both major and minor ticks are affected
            bottom='off',      # ticks along the bottom edge are off
            top='off')         # ticks along the top edge are off

    lns = l1+l2+l3+l4+l5
    labs = [l.get_label() for l in lns]
    ax4.legend(lns, labs, loc='lower right')


    mp.savefig("attractive_mapping_densities.pdf", 
                #This is simple recomendation for publication plots
                dpi=1000, 
                # Plot will be occupy a maximum of available space
                bbox_inches='tight', 
                pad_inches=0.02
                ) 
