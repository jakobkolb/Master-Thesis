import numpy as np
import os
import pygraphviz as pgv

Rflows = {}
Sflows = {}
r, s = 0, 0

for i in range(3):
    Rflows[`i`] = np.loadtxt('rep_data/Rflows0'+`i+1`+'.tsv')
    Sflows[`i`] = np.loadtxt('rep_data/Sflows0'+`i+1`+'.tsv')
N_datasets = 0

labels=['A)','B)','C)']

for i in range(3):
    
    jr = Rflows[`i`]
    js = Sflows[`i`]

    RJmax = np.amax(Rflows[`i`])
    SJmax = np.amax(Sflows[`i`])
    Jmax = max( RJmax, SJmax)/14.
    #Jmax = 2.5
    jr = Rflows[`i`]/Jmax
    js = Sflows[`i`]/Jmax

    chart = pgv.AGraph(directed=True, rankdir='RL')
    chart.graph_attr['label']=labels[i]
    chart.graph_attr['labelloc']='top'
    chart.graph_attr['labeljust']='left'
    chart.graph_attr['fontsize']='25'
    chart.graph_attr['margin']='0.1'

    chart.node_attr['shape']='square'
    chart.node_attr['fixedsize']='true'
    chart.node_attr['width']='0.8'

    chart.add_node('III on', color='blue', label='')
    chart.add_node('II on', color='blue', label='')
    chart.add_node('I on', color='blue', label='')
    chart.add_node('III off',color='red', label='')
    chart.add_node('II off',color='red', label='')
    chart.add_node('I off',color='red', label='')
    chart.add_node('Sink', label='')
    chart.add_node('Bath', label='')
    chart.add_node('BIi1', color='blue', shape='circle', label='', width='0.5')
    chart.add_node('BIi0',color='red', shape='circle', label='', width='0.5')
    chart.add_node('BIo1', color='blue', shape='circle', label='', width='0.5')
    chart.add_node('BIo0',color='red', shape='circle', label='', width='0.5')
    chart.add_node('BIIi1', color='blue', shape='circle', label='', width='0.5')
    chart.add_node('BIIi0',color='red', shape='circle', label='', width='0.5')
    chart.add_node('BIIo1', color='blue', shape='circle', label='', width='0.5')
    chart.add_node('BIIo0',color='red', shape='circle', label='', width='0.5')

    BIi=chart.add_subgraph(['BIi1','BIi0'])
    BIi.graph_attr['rank']='same'
    BIo=chart.add_subgraph(['BIo1','BIo0'])
    BIo.graph_attr['rank']='same'


    cluster_BI=chart.add_subgraph(['BIi','BIo'],
            name='cluster_BI',
            style='filled',
            color='grey',
            label='Inner Barrier Border')



    BIi=chart.add_subgraph(['BIIi1','BIIi0'])
    BIi.graph_attr['rank']='same'
    BIo=chart.add_subgraph(['BIIo1','BIIo0'])
    BIo.graph_attr['rank']='same'

    cluster_BII=chart.add_subgraph(['BIIi','BIIo'],
            name='cluster_BII',
            style='filled',
            color='grey',
            label='Outer Barrier Border')

    I=chart.add_subgraph(['I on','I off'])
    I.graph_attr['rank']='same'
    II=chart.add_subgraph(['II on','II off'])
    II.graph_attr['rank']='same'
    III=chart.add_subgraph(['III on','III off'])
    III.graph_attr['rank']='same'


    if js[2,0]>0:
        cluster_BI.add_edge('BIo0','BIi0', penwidth=js[2,0])
    if js[2,0]<0:
        cluster_BI.add_edge('BIo0','BIi0', penwidth=-js[2,0], dir='back')
    if js[2,1]>0:
        cluster_BI.add_edge('BIo1','BIi1', penwidth=js[2,1])
    if js[2,1]<0:
        cluster_BI.add_edge('BIo1','BIi1', penwidth=-js[2,1], dir='back')
    if js[5,0]>0:
        cluster_BII.add_edge('BIIo0','BIIi0', penwidth=js[5,0])
    if js[5,0]<0:
        cluster_BII.add_edge('BIIo0','BIIi0', penwidth=-js[5,0], dir='back')
    if js[5,1]>0:
        cluster_BII.add_edge('BIIo1','BIIi1', penwidth=js[5,1])
    if js[5,1]<0:
        cluster_BII.add_edge('BIIo1','BIIi1', penwidth=-js[5,1], dir='back')

    if jr[1]>0: 
        cluster_BI.add_edge('BIi0','BIi1', penwidth=jr[1])
    if jr[1]<0: 
        cluster_BI.add_edge('BIi0','BIi1', penwidth=-jr[1], dir='back')
    if jr[2]>0:
        cluster_BI.add_edge('BIo0','BIo1', penwidth=jr[2])
    if jr[2]<0:
        cluster_BI.add_edge('BIo0','BIo1', penwidth=-jr[2], dir='back')
    if jr[4]>0:
        cluster_BII.add_edge('BIIi0','BIIi1', penwidth=jr[4])
    if jr[4]<0:
        cluster_BII.add_edge('BIIi0','BIIi1', penwidth=-jr[4], dir ='back')
    if jr[5]>0:
        cluster_BII.add_edge('BIIo0','BIIo1', penwidth=jr[5])
    if jr[5]<0:
        cluster_BII.add_edge('BIIo0','BIIo1', penwidth=-jr[5], dir='back')


#into the sink
    if js[0,1]>0:
        chart.add_edge('I on', 'Sink', penwidth=js[0,1])
    if js[0,1]<0:
        chart.add_edge('I on', 'Sink', penwidth=-js[0,1], dir="back")
    if js[0,0]>0:
        chart.add_edge('I off', 'Sink', penwidth=js[0,0])
    if js[0,0]<0:
        chart.add_edge('I off', 'Sink', penwidth=-js[0,0], dir="back")
#around the inner border
    if js[1,1]>0:
        chart.add_edge('BIi1', 'I on', penwidth=js[1,1])
    if js[1,1]<0:
        chart.add_edge('BIi1', 'I on', penwidth=-js[1,1], dir="back")
    if js[1,0]>0:
        chart.add_edge('BIi0', 'I off', penwidth=js[1,0])
    if js[1,0]<0:
        chart.add_edge('BIi0', 'I off', penwidth=-js[1,0], dir="back")
    if js[3,1]>0:
        chart.add_edge('II on', 'BIo1', penwidth=js[3,1])
    if js[3,1]<0:
        chart.add_edge('II on', 'BIo1', penwidth=-js[3,1], dir="back")
    if js[3,0]>0:
        chart.add_edge('II off', 'BIo0', penwidth=js[3,0])
    if js[3,0]<0:
        chart.add_edge('II off', 'BIo0', penwidth=-js[3,0], dir="back")
#around the outer border
    if js[4,1]>0:
        chart.add_edge('BIIi1', 'II on', penwidth=js[4,1])
    if js[4,1]<0:
        chart.add_edge('BIIi1', 'II on', penwidth=-js[4,1], dir="back")
    if js[4,0]>0:
        chart.add_edge('BIIi0', 'II off', penwidth=js[4,0])
    if js[4,0]<0:
        chart.add_edge('BIIi0', 'II off', penwidth=-js[4,0], dir="back")
    if js[6,1]>0:
        chart.add_edge('III on', 'BIIo1', penwidth=js[6,1])
    if js[6,1]<0:
        chart.add_edge('III on', 'BIIo1', penwidth=-js[6,1], dir="back")
    if js[6,0]>0:
        chart.add_edge('III off', 'BIIo0', penwidth=js[6,0])
    if js[6,0]<0:
        chart.add_edge('III off', 'BIIo0', penwidth=-js[6,0], dir="back")
    if js[7,1]>0:
        chart.add_edge('Bath', 'III on', penwidth=js[7,1])
    if js[7,1]<0:
        chart.add_edge('Bath', 'III on', penwidth=-js[7,1], dir="back")
    if js[7,0]>0:
        chart.add_edge('Bath', 'III off', penwidth=js[7,0])
    if js[7,0]<0:
        chart.add_edge('Bath', 'III off', penwidth=-js[7,0], dir="back")

    if jr[0]>0:
        chart.add_edge('I off', 'I on', penwidth=jr[0])
    if jr[0]<0:
        chart.add_edge('I off', 'I on', penwidth=-jr[0], dir="back")
    if jr[3]>0:
        chart.add_edge('II off', 'II on', penwidth=jr[3])
    if jr[3]<0:
        chart.add_edge('II off', 'II on', penwidth=-jr[3], dir="back")
    if jr[5]>0:
        chart.add_edge('III off', 'III on', penwidth=jr[6])
    if jr[5]<0:
        chart.add_edge('III off', 'III on', penwidth=-jr[6], dir="back")
    chart.write('flowchart.dot')

    chart.layout(prog='dot')
    #chart.layout()
    chart.draw('rep_flowchart'+`i`+'.pdf')

