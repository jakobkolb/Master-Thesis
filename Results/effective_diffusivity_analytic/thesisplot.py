#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from rate import *
from scipy.optimize import curve_fit
import sympy

kt = 1.
d = 1.
a = 6.
b = 11.
Ua = -3.
Ur = 3.
Uma = -1.5
Umr = 1.5
rd = [250,2.5,0.25]
l = a-1.
g = (b-a)/l

list_of_files = range(1,3,1)

rdens1 = np.loadtxt('rep_data/table1.tsv')
rdens2 = np.loadtxt('rep_data/table2.tsv')
rdens3 = np.loadtxt('rep_data/table3.tsv')

adens1 = np.loadtxt('att_data/table1.tsv')
adens2 = np.loadtxt('att_data/table2.tsv')
adens3 = np.loadtxt('att_data/table3.tsv')

def theta(x):
    return 0.5*(np.sign(x)+1)

def calc_dens(r,d1,d2,d3):
    global a
    global b
    global Um
    global kd
    rho = (theta(r-1.)-theta(r-a+0.0001))*kd/(d1)*(r-1.)/(r)+(theta(r-a+0.0001)-theta(r-b+0.0001))*kd/(d2)*(np.exp(Um)*(a-1.)/a + (r-a)/(r*a))+theta(r-b+0.0001)*kd/(d3)*((a-1.)/a + (b-a)/(b*a) + (r-b)/(r*b))
    return rho

def calc_diff(rvals,dens,a,b,kd,Um):
    rvals.flatten()
    popt, pcov = curve_fit(calc_dens,rvals,dens)
    print popt

    return popt

Um = Uma
kd = calc_rate(Ur,rd[2],g,l,kt,d)
d1,d2,d3 = calc_diff(rdens2[:,0],rdens2[:,3],a,b,kd,Umr)
print d1,d2,d3

fig = mp.figure()
ax = fig.add_subplot(111)
ax.plot(rdens2[:,0],rdens2[:,3],'x')
ax.plot(rdens2[:,0],calc_dens(rdens1[:,0],d1,d2,d3),'x')
ax.plot(rdens2[:,0],calc_dens(rdens1[:,0],1,1,1)/calc_dens(20.,1,1,1),'.')

mp.show()

height = 0.6

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

fig1 = mp.figure()
#You must select the correct size of the plot in advance
fig1.set_size_inches(3.54,height*3.54) 

ax1 = fig1.add_subplot(111)
ax1.text(0.02, 0.95, 'A)', transform=ax1.transAxes, fontsize=12, va='top')
mp.plot(rdens1[:,0], rdens1[:,3], color = '0.55')
mp.plot(rdens1[:,0], rdens1[:,1], 'r--')
mp.plot(rdens1[:,0], rdens1[:,2], 'b:')
ax1.set_ylim([0,1.41])
mp.yticks([0,0.7,1.4])
mp.xticks([1,6,11])
ax1.set_xlim([0,18])
ax1.set_ylabel(r'$\rho_n(r)$')
mp.xticks((1,6,11,17),(r'${\textstyle R_s}$', r'${\textstyle a}$', r'${\textstyle b}$', '$r$'))

ax1.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off


mp.savefig("d1.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )

fig2 = mp.figure()
#You must select the correct size of the plot in advance
fig2.set_size_inches(3.54,height*3.54) 
ax2 = fig2.add_subplot(111)
ax2.text(0.02, 0.95, 'B)', transform=ax2.transAxes, fontsize=12, va='top')
mp.plot(rdens2[:,0], rdens2[:,3], color = '0.55')
mp.plot(rdens2[:,0], rdens2[:,1], 'r--')
mp.plot(rdens2[:,0], rdens2[:,2], 'b:')
ax2.set_ylim([0,1.41])
mp.yticks([0,0.7,1.4])
mp.xticks([1,6,11])
ax2.set_xlim([0,18])
ax2.set_ylabel(r'$\rho_n(r)$')
mp.xticks((1,6,11,17),(r'$\textstyle R_s$', r'$\textstyle a$', r'$\textstyle b$', '$r$'))


ax2.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

mp.savefig("d2.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
fig3 = mp.figure()
#You must select the correct size of the plot in advance
fig3.set_size_inches(3.81,height*3.54) 
ax3 = fig3.add_subplot(111)
ax3.text(0.02, 0.95, 'C)', transform=ax3.transAxes, fontsize=12, va='top')
p32 = mp.plot(rdens3[:,0], rdens3[:,3], color = '0.55', label = r'$\rho_m(r)$')
p30 = mp.plot(rdens3[:,0], rdens3[:,1], 'r--', label = r'$\rho_1(r)$')
p31 = mp.plot(rdens3[:,0], rdens3[:,2], 'b:', label = r'$\rho_2(r)$')
ax3.set_ylim([0,1.41])
mp.yticks([0,0.7,1.4])
ax3.set_ylabel(r'$\rho_n(r)$')
ax3.set_xlim([0,18])
mp.xticks((1,6,11,17),(r'$\textstyle R_s$', r'$\textstyle a$', r'$\textstyle b$', '$r$'))


ax3.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

lns = p30 + p31 + p32
labs = [l.get_label() for l in lns]
ax3.legend(lns, labs, loc='lower right')


mp.savefig("d3.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            ) 
label_height = 0.85
label_width = 0.0


fig4 = mp.figure()
#You must select the correct size of the plot in advance
fig4.set_size_inches(3.54,height*3.54) 

ax4 = fig4.add_subplot(111)
ax4.text(0.02, label_height, 'A)', transform=ax1.transAxes, fontsize=12, va='top')
mp.plot(adens1[:,0], adens1[:,3], color = '0.55')
mp.plot(adens1[:,0], adens1[:,1], 'r--')
mp.plot(adens1[:,0], adens1[:,2], 'b:')
ax4.set_ylim([0,20])
mp.yticks([0,4,8,12,16])
mp.xticks([1,6,11])
ax4.set_xlim([0,18])
ax4.set_ylabel(r'$\rho_n(r)$')
mp.xticks((1,6,11,17),(r'$\textstyle R_s$', r'$\textstyle a$', r'$\textstyle b$', '$r$'))


ax4.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

mp.savefig("d4.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
fig5 = mp.figure()
#You must select the correct size of the plot in advance
fig5.set_size_inches(3.54,height*3.54) 
ax5 = fig5.add_subplot(111)
ax5.text(label_width, label_height, 'B)', transform=ax2.transAxes, fontsize=12, va='top')
mp.plot(adens2[:,0], adens2[:,3], color = '0.55')
mp.plot(adens2[:,0], adens2[:,1], 'r--')
mp.plot(adens2[:,0], adens2[:,2], 'b:')
ax5.set_ylim([0,4.5])
mp.yticks([0,1,2,3,4])
mp.xticks([1,6,11])
ax5.set_xlim([0,18])
ax5.set_ylabel(r'$\rho_n(r)$')
mp.xticks((1,6,11,17),(r'$\textstyle R_s$', r'$\textstyle a$', r'$\textstyle b$', '$r$'))


ax5.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

mp.savefig("d5.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
fig6 = mp.figure()
#You must select the correct size of the plot in advance
fig6.set_size_inches(3.71,height*3.54) 
ax6 = fig6.add_subplot(111)
ax6.text(label_width, label_height, 'C)', transform=ax3.transAxes, fontsize=12, va='top')
p62 = mp.plot(adens3[:,0], adens3[:,3], color = '0.55', label = r'$\rho_m(r)$')
p60 = mp.plot(adens3[:,0], adens3[:,1], 'r--', label = r'$\rho_1(r)$')
p61 = mp.plot(adens3[:,0], adens3[:,2], 'b:', label = r'$\rho_2(r)$')
ax6.set_ylim([0,3.5])
mp.yticks([0,1,2,3])
ax6.set_ylabel(r'$\rho_n(r)$')
ax6.set_xlim([0,18])
mp.xticks((1,6,11,17),(r'$\textstyle R_s$', r'$\textstyle a$', r'$\textstyle b$', '$r$'))


ax6.tick_params(\
        axis='x',          # changes apply to the x-axis
        which='both',      # both major and minor ticks are affected
        bottom='off',      # ticks along the bottom edge are off
        top='off')         # ticks along the top edge are off

lns = p60 + p61 + p62
labs = [l.get_label() for l in lns]
ax6.legend(lns, labs, loc='upper right')


mp.savefig("d6.pdf", 
            #This is simple recomendation for publication plots
            dpi=1000, 
            # Plot will be occupy a maximum of available space
            bbox_inches='tight', 
            pad_inches=0.02
            )
