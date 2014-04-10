import numpy as np
from scipy.integrate import odeint
import matplotlib.pyplot as mp

def f(r):
    f1, f2 = 0,0
    if r < 1+l:
        f1 = 0
        f2 = 0
    elif r<1+l+l*g/2. and r>1+l:
        f1 = alpha1
        f2 = alpha2
    elif r<1+l+l*g and r>1+l+l*g/2.:
        f1 = -alpha1
        f2 = -alpha2
    elif r>1+l+g*l:
        f1 = 0
        f2 = 0
    return f1, f2
def fpe(x,r):
    f1, f2 = f(r)
    A = np.array(
            [[-(f1/d+2/r), 0, (w12/d-2*f1/d/r), -w21/d],
             [0, -(f2/d+2/r), -w12/d, (w21/d-2*f2/d/r)],
             [1,0,0,0],
             [0,1,0,0]])
    return np.dot(A,x)

def test(x,r):
    A = np.array([[-2/r,0],
                  [1,0]])
    return np.dot(A,x)

if __name__ == '__main__':
    r = np.linspace(1,5,num=1000)

    alpha1 = 1
    alpha2 = -1
    d = 1.
    w12 = 10
    w21 = 10
    l = 1.
    g = 1.

    rhozero = [0,0,1,1]
    testzero = [1,0]

    uvals = np.zeros((1000,2))
    for i in range(1000):
        uvals[i] = f(r[i])

    sol1 = odeint(fpe,rhozero,r)
    sol2 = odeint(test,testzero,r) 
    print sol1    
    mp.plot(r,sol1[:,2:4])
    mp.plot(r,uvals)
    #mp.plot(r,sol2[:,1])
    mp.show()

