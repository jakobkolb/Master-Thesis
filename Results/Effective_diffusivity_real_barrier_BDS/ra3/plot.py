#!/usr/bin/env python

import numpy as np
import matplotlib.pyplot as mp
from scipy.optimize import curve_fit
data = np.loadtxt('mean_square_radius.tsv')


fig = mp.figure()
for i in range(np.shape(data)[1]):
    mp.plot(data[:,i])

mp.show()
