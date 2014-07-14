import sympy


def calc_rate(u,rd,g,t,kt,d):

    x = sympy.Symbol('x')
    a = sympy.Symbol('a')
    b = sympy.Symbol('b')
   
    k=(-2*sympy.exp(u+2*(1+b)*x)*(1+a*x)*(-1+b*x)-2*b*sympy.exp((2+a+b)*x)*x*(1+b*x)+2*b*sympy.exp((3*a+b)*x)*x*(1+b*x)
            -4*b*sympy.exp(u+3*a*x+b*x)*x*(1+b*x)+2*b*sympy.exp(2*u+3*a*x+b*x)*x*(1+b*x)
            +4*b*sympy.exp(u+(2+a+b)*x)*x*(1+b*x)-2*b*sympy.exp(2*u+(2+a+b)*x)*x*(1+b*x)
            +sympy.exp(4*a*x)*(-1+a*x)*(1+b*x)-sympy.exp(2*(1+a)*x)*(-1+a*x)*(1+b*x)
            -2*sympy.exp(u+4*a*x)*(-1+a*x)*(1+b*x)+sympy.exp(2*u+4*a*x)*(-1+a*x)*(1+b*x)
            -2*sympy.exp(u+2*(1+a)*x)*(1+a*x)*(1+b*x)-sympy.exp(2*(u+x+b*x))*(1+a*x)*(1+b*x)
            -sympy.exp(2*(u+(a+b)*x))*(-1+3*a*x)*(1+b*x)+sympy.exp(2*(u+x+a*x))*(1+3*a*x)*(1+b*x)
            +sympy.exp(2*(1+b)*x)*(1+a*x)*(-1+3*b*x)-sympy.exp(2*(a+b)*x)*(1+a*x)*(-1+3*b*x)
            +2*sympy.exp(u+2*(a+b)*x)*(-1+b*x+a*(x-5*b*x*x)))/(2*sympy.exp(u+2*(1+b)*x)*(1+a*x)*(1+(-2+b)*x)
            +2*sympy.exp((2+a+b)*x)*x*(-2+a-a*x+a*a*x-b*x)-4*sympy.exp(u+(2+a+b)*x)*x*(-2+a-a*x+a*a*x-b*x)
            +2*sympy.exp(2*u+(2+a+b)*x)*x*(-2+a-a*x+a*a*x-b*x)+2*sympy.exp(u+2*(1+a)*x)*(-1+(-2+a)*x)*(1+b*x)
            +sympy.exp(4*a*x)*(-1+a*x)*(1+b*x)-2*sympy.exp(u+4*a*x)*(-1+a*x)*(1+b*x)
            +sympy.exp(2*u+4*a*x)*(-1+a*x)*(1+b*x)+sympy.exp(2*(u+x+a*x))*(1+(2+a)*x)*(1+b*x)
            -sympy.exp(2*(1+a)*x)*(-1+(-2+3*a)*x)*(1+b*x)+sympy.exp(2*(1+b)*x)*(1+a*x)*(-1+(2+b)*x)
            -sympy.exp(2*(u+x+b*x))*(1+a*x)*(1+(-2+3*b)*x)-sympy.exp(2*(u+(a+b)*x))*(-1+(4+a-3*b)*x+3*(a*(-2+b)+2*b)*x*x)
            -sympy.exp(2*(a+b)*x)*(-1+(4-3*a+b)*x+(-2*b+a*(2+3*b))*x*x)
            -2*sympy.exp(u+2*(a+b)*x)*(1+(-4+a+b)*x+(-2*b+a*(2+5*b))*x*x)
            +2*sympy.exp((3*a+b)*x)*x*(2+a*a*x+b*x-a*(1+x))-4*sympy.exp(u+3*a*x+b*x)*x*(2+a*a*x+b*x-a*(1+x))
            +2*sympy.exp(2*u+3*a*x+b*x)*x*(2+a*a*x+b*x-a*(1+x)))
    tmp = k.subs(x,1./rd).subs(a,1+t).subs(b,1+(1+g)*t)
    out = tmp.evalf()
    return out

def calc_att_limit(rd,g,t,kt,d):

    x = sympy.Symbol('x')
    a = sympy.Symbol('a')
    b = sympy.Symbol('b')
  
    k = (-sympy.exp(4*a*x)+sympy.exp(2*(1+a)*x)+sympy.exp(2*(a+b)*x)-sympy.exp(2*x+2*b*x)+a*sympy.exp(4*a*x)*x
            -b*sympy.exp(4*a*x)*x+a*sympy.exp(2*(a+b)*x)*x-3*b*sympy.exp(2*(a+b)*x)*x-2*b*sympy.exp((2+a+b)*x)*x
            +2*b*sympy.exp((3*a+b)*x)*x-a*sympy.exp(2*x+2*a*x)*x+b*sympy.exp(2*x+2*a*x)*x-a*sympy.exp(2*x+2*b*x)*x
            +3*b*sympy.exp(2*x+2*b*x)*x+a*b*sympy.exp(4*a*x)*x*x-3*a*b*sympy.exp(2*(a+b)*x)*x*x
            -2*b*b*sympy.exp((2+a+b)*x)*x*x+2*b*b*sympy.exp((3*a+b)*x)*x*x-a*b*sympy.exp(2*x+2*a*x)*x*x
            +3*a*b*sympy.exp(2*x+2*b*x)*x*x)/(-sympy.exp(4*a*x)+sympy.exp(2*(1+a)*x)+sympy.exp(2*(a+b)*x)
            -sympy.exp(2*x+2*b*x)+a*sympy.exp(4*a*x)*x-b*sympy.exp(4*a*x)*x-4*sympy.exp(2*(a+b)*x)*x
            +3*a*sympy.exp(2*(a+b)*x)*x-b*sympy.exp(2*(a+b)*x)*x-4*sympy.exp((2+a+b)*x)*x+2*a*sympy.exp((2+a+b)*x)*x
            +4*sympy.exp((3*a+b)*x)*x-2*a*sympy.exp((3*a+b)*x)*x+2*sympy.exp(2*x+2*a*x)*x-3*a*sympy.exp(2*x+2*a*x)*x
            +b*sympy.exp(2*x+2*a*x)*x+2*sympy.exp(2*x+2*b*x)*x-a*sympy.exp(2*x+2*b*x)*x+b*sympy.exp(2*x+2*b*x)*x
            +a*b*sympy.exp(4*a*x)*x*x-2*a*sympy.exp(2*(a+b)*x)*x*x+2*b*sympy.exp(2*(a+b)*x)*x*x
            -3*a*b*sympy.exp(2*(a+b)*x)*x*x-2*a*sympy.exp((2+a+b)*x)*x*x+2*a*a*sympy.exp((2+a+b)*x)*x*x
            -2*b*sympy.exp((2+a+b)*x)*x*x-2*a*sympy.exp((3*a+b)*x)*x*x+2*a*a*sympy.exp((3*a+b)*x)*x*x
            +2*b*sympy.exp((3*a+b)*x)*x*x+2*b*sympy.exp(2*x+2*a*x)*x*x-3*a*b*sympy.exp(2*x+2*a*x)*x*x+2*a*sympy.exp(2*x+2*b*x)*x*x+a*b*sympy.exp(2*x+2*b*x)*x*x)

    tmp = k.subs(x,1./rd).subs(a,1+t).subs(b,1+(1+g)*t)
    out = tmp.evalf()
    return out

def calc_rep_limit(rd,g,t,kt,d):

    x = sympy.Symbol('x')
    a = sympy.Symbol('a')
    b = sympy.Symbol('b')
  
    k = (-sympy.exp(4*a*x)+sympy.exp(2*x+2*a*x)-sympy.exp(2*x+2*b*x)+sympy.exp(2*a*x+2*b*x)+a*sympy.exp(4*a*x)*x
            -b*sympy.exp(4*a*x)*x-3*a*sympy.exp(2*(a+b)*x)*x+b*sympy.exp(2*(a+b)*x)*x-2*b*sympy.exp((2+a+b)*x)*x
            +2*b*sympy.exp((3*a+b)*x)*x+3*a*sympy.exp(2*x+2*a*x)*x+b*sympy.exp(2*x+2*a*x)*x-a*sympy.exp(2*x+2*b*x)*x
            -b*sympy.exp(2*x+2*b*x)*x+a*b*sympy.exp(4*a*x)*x*x-3*a*b*sympy.exp(2*(a+b)*x)*x*x
            -2*b*b*sympy.exp((2+a+b)*x)*x*x+2*b*b*sympy.exp((3*a+b)*x)*x*x+3*a*b*sympy.exp(2*x+2*a*x)*x*x
            -a*b*sympy.exp(2*x+2*b*x)*x*x)/(-sympy.exp(4*a*x)+sympy.exp(2*x+2*a*x)-sympy.exp(2*x+2*b*x)
            +sympy.exp(2*a*x+2*b*x)+a*sympy.exp(4*a*x)*x-b*sympy.exp(4*a*x)*x-4*sympy.exp(2*(a+b)*x)*x
            -a*sympy.exp(2*(a+b)*x)*x+3*b*sympy.exp(2*(a+b)*x)*x-4*sympy.exp((2+a+b)*x)*x
            +2*a*sympy.exp((2+a+b)*x)*x+4*sympy.exp((3*a+b)*x)*x-2*a*sympy.exp((3*a+b)*x)*x
            +2*sympy.exp(2*x+2*a*x)*x+a*sympy.exp(2*x+2*a*x)*x+b*sympy.exp(2*x+2*a*x)*x
            +2*sympy.exp(2*x+2*b*x)*x-a*sympy.exp(2*x+2*b*x)*x-3*b*sympy.exp(2*x+2*b*x)*x
            +a*b*sympy.exp(4*a*x)*x*x+6*a*sympy.exp(2*(a+b)*x)*x*x-6*b*sympy.exp(2*(a+b)*x)*x*x
            -3*a*b*sympy.exp(2*(a+b)*x)*x*x-2*a*sympy.exp((2+a+b)*x)*x*x+2*a*a*sympy.exp((2+a+b)*x)*x*x
            -2*b*sympy.exp((2+a+b)*x)*x*x-2*a*sympy.exp((3*a+b)*x)*x*x+2*a*a*sympy.exp((3*a+b)*x)*x*x
            +2*b*sympy.exp((3*a+b)*x)*x*x+2*b*sympy.exp(2*x+2*a*x)*x*x+a*b*sympy.exp(2*x+2*a*x)*x*x
            +2*a*sympy.exp(2*x+2*b*x)*x*x-3*a*b*sympy.exp(2*x+2*b*x)*x*x)



    tmp = k.subs(x,1./rd).subs(a,1+t).subs(b,1+(1+g)*t)
    out = tmp.evalf()
    return out
