import numpy as np
import os
import pygraphviz as pgv

Rflows = {}
Sflows = {}
r, s = 0, 0

for i in range(3):
    Rflows[`i`] = np.loadtxt('data/Rflows0'+`i+1`+'.tsv')
    Sflows[`i`] = np.loadtxt('data/Sflows0'+`i+1`+'.tsv')
N_datasets = 0

for i in range(3):
    
    jr = Rflows[`i`]
    js = Sflows[`i`]

    print jr[0]
    print js[0,:]
    print js[1,:]
    print -jr[0] - js[0,0] + js[0,1]

    RJmax = np.amax(Rflows[`i`])
    SJmax = np.amax(Sflows[`i`])
    Jmax = max( RJmax, SJmax)/8.
    jr = Rflows[`i`]/Jmax
    js = Sflows[`i`]/Jmax

    chart = pgv.AGraph(directed=True, rankdir='RL')

    chart.node_attr['shape']='square'
    chart.node_attr['fixedsize']='true'
    chart.node_attr['width']='0.8'

    chart.add_node('III on', color='blue')
    chart.add_node('II on', color='blue')
    chart.add_node('I on', color='blue')
    chart.add_node('III off',color='red')
    chart.add_node('II off',color='red')
    chart.add_node('I off',color='red')
    chart.add_node('Sink')
    chart.add_node('Bath')
    chart.add_node('BIi1')
    chart.add_node('BIi0')
    chart.add_node('BIo1')
    chart.add_node('BIo0')
    chart.add_node('BIIi1')
    chart.add_node('BIIi0')
    chart.add_node('BIIo1')
    chart.add_node('BIIo0')

    I=chart.add_subgraph(['I on','I off'])
    I.graph_attr['rank']='same'
    II=chart.add_subgraph(['II on','II off'])
    II.graph_attr['rank']='same'
    III=chart.add_subgraph(['III on','III off'])
    III.graph_attr['rank']='same'


    if js[0,1]>0:
        chart.add_edge('I on', 'Sink', penwidth=js[0,1])
    if js[0,1]<0:
        chart.add_edge('I on', 'Sink', penwidth=-js[0,1], dir="back")
    if js[0,0]>0:
        chart.add_edge('I off', 'Sink', penwidth=js[0,0])
    if js[0,0]<0:
        chart.add_edge('I off', 'Sink', penwidth=-js[0,0], dir="back")
    if js[1,1]>0:
        chart.add_edge('II on', 'I on', penwidth=js[1,1])
    if js[1,1]<0:
        chart.add_edge('II on', 'I on', penwidth=-js[1,1], dir="back")
    if js[1,0]>0:
        chart.add_edge('II off', 'I off', penwidth=js[1,0])
    if js[1,0]<0:
        chart.add_edge('II off', 'I off', penwidth=-js[1,0], dir="back")
    if js[2,1]>0:
        chart.add_edge('III on', 'II on', penwidth=js[2,1])
    if js[2,1]<0:
        chart.add_edge('III on', 'II on', penwidth=-js[2,1], dir="back")
    if js[2,0]>0:
        chart.add_edge('III off', 'II off', penwidth=js[2,0])
    if js[2,0]<0:
        chart.add_edge('III off', 'II off', penwidth=-js[2,0], dir="back")
    if js[3,1]>0:
        chart.add_edge('Bath', 'III on', penwidth=js[3,1])
    if js[3,1]<0:
        chart.add_edge('Bath', 'III on', penwidth=-js[3,1], dir="back")
    if js[3,0]>0:
        chart.add_edge('Bath', 'III off', penwidth=js[3,0])
    if js[3,0]<0:
        chart.add_edge('Bath', 'III off', penwidth=-js[3,0], dir="back")

    if jr[0]>0:
        chart.add_edge('I off', 'I on', penwidth=jr[0])
    if jr[0]<0:
        chart.add_edge('I off', 'I on', penwidth=-jr[0], dir="back")
    if jr[1]>0:
        chart.add_edge('II off', 'II on', penwidth=jr[1])
    if jr[1]<0:
        chart.add_edge('II off', 'II on', penwidth=-jr[1], dir="back")
    if jr[2]>0:
        chart.add_edge('III off', 'III on', penwidth=jr[2])
    if jr[2]<0:
        chart.add_edge('III off', 'III on', penwidth=-jr[2], dir="back")

    chart.layout(prog='dot')
    #chart.layout()
    chart.draw('flowchart'+`i`+'.pdf')

