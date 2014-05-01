fk[a_, b_, u_, 
  x_] := (-2 E^(u + 2 (1 + b) x) (1 + a x) (-1 + b x) - 
    2 b E^((2 + a + b) x) x (1 + b x) + 
    2 b E^((3 a + b) x) x (1 + b x) - 
    4 b E^(u + 3 a x + b x) x (1 + b x) + 
    2 b E^(2 u + 3 a x + b x) x (1 + b x) + 
    4 b E^(u + (2 + a + b) x) x (1 + b x) - 
    2 b E^(2 u + (2 + a + b) x) x (1 + b x) + 
    E^(4 a x) (-1 + a x) (1 + b x) - 
    E^(2 (1 + a) x) (-1 + a x) (1 + b x) - 
    2 E^(u + 4 a x) (-1 + a x) (1 + b x) + 
    E^(2 u + 4 a x) (-1 + a x) (1 + b x) - 
    2 E^(u + 2 (1 + a) x) (1 + a x) (1 + b x) - 
    E^(2 (u + x + b x)) (1 + a x) (1 + b x) - 
    E^(2 (u + (a + b) x)) (-1 + 3 a x) (1 + b x) + 
    E^(2 (u + x + a x)) (1 + 3 a x) (1 + b x) + 
    E^(2 (1 + b) x) (1 + a x) (-1 + 3 b x) - 
    E^(2 (a + b) x) (1 + a x) (-1 + 3 b x) + 
    2 E^(u + 2 (a + b) x) (-1 + b x + a (x - 5 b x^2)))/(2 E^(
     u + 2 (1 + b) x) (1 + a x) (1 + (-2 + b) x) + 
    2 E^((2 + a + b) x) x (-2 + a - a x + a^2 x - b x) - 
    4 E^(u + (2 + a + b) x) x (-2 + a - a x + a^2 x - b x) + 
    2 E^(2 u + (2 + a + b) x) x (-2 + a - a x + a^2 x - b x) + 
    2 E^(u + 2 (1 + a) x) (-1 + (-2 + a) x) (1 + b x) + 
    E^(4 a x) (-1 + a x) (1 + b x) - 
    2 E^(u + 4 a x) (-1 + a x) (1 + b x) + 
    E^(2 u + 4 a x) (-1 + a x) (1 + b x) + 
    E^(2 (u + x + a x)) (1 + (2 + a) x) (1 + b x) - 
    E^(2 (1 + a) x) (-1 + (-2 + 3 a) x) (1 + b x) + 
    E^(2 (1 + b) x) (1 + a x) (-1 + (2 + b) x) - 
    E^(2 (u + x + b x)) (1 + a x) (1 + (-2 + 3 b) x) - 
    E^(2 (u + (a + b) x)) (-1 + (4 + a - 3 b) x + 
       3 (a (-2 + b) + 2 b) x^2) - 
    E^(2 (a + 
        b) x) (-1 + (4 - 3 a + b) x + (-2 b + a (2 + 3 b)) x^2) - 
    2 E^(u + 
      2 (a + b) x) (1 + (-4 + a + b) x + (-2 b + a (2 + 5 b)) x^2) + 
    2 E^((3 a + b) x) x (2 + a^2 x + b x - a (1 + x)) - 
    4 E^(u + 3 a x + b x) x (2 + a^2 x + b x - a (1 + x)) + 
    2 E^(2 u + 3 a x + b x) x (2 + a^2 x + b x - a (1 + x)))

(*Calculate limiting behaviour for x \[Rule]0*)

Assuming[b > a > 1, Limit[k, x -> 0]]

klim0[a_, b_, u_] := (b - b E^u + a (-1 - 2 b + E^u))/( 
 2 (b - b E^u + a (-1 - b + E^u)))

(*Calculate limiting behaviour for x \[Rule] oo by hand, since \
mathematica resists do it... terefore only collect terms with leading \
exponents from k and simplify the resulting rational function*)

Simplify[(-E^(2 (u + (a + b) x)) (-1 + 3 a x) (1 + b x) - 
    E^(2 (a + b) x) (1 + a x) (-1 + 3 b x) + 
    2 E^(u + 2 (a + b) x) (-1 + b x + a (x - 5 b x^2)))/(-E^(
      2 (u + (a + b) x)) (-1 + (4 + a - 3 b) x + 
       3 (a (-2 + b) + 2 b) x^2) - 
    E^(2 (a + 
        b) x) (-1 + (4 - 3 a + b) x + (-2 b + a (2 + 3 b)) x^2) - 
    2 E^(u + 
      2 (a + b) x) (1 + (-4 + a + b) x + (-2 b + a (2 + 5 b)) x^2))]

(*Then take the limit for x to infinity*)

Limit[((1 + a x + E^u (-1 + 3 a x)) (-1 + 3 b x + 
      E^u (1 + b x)))/(-1 + (4 - 3 a + b) x + (2 a - 2 b + 
       3 a b) x^2 + 
    E^(2 u) (-1 + (4 + a - 3 b) x + 3 (a (-2 + b) + 2 b) x^2) + 
    2 E^u (1 + (-4 + a + b) x + (2 a - 2 b + 5 a b) x^2)), 
 x -> Infinity]

kliminf[a_, b_, u_] := (a b (3 + E^u))/(
 2 b (-1 + E^u) + a (2 - 2 E^u + b (3 + E^u)))

(*Do some plot of the results*)

kliminfdebye[a_, b_, u_] := a*b/(a*b - (b - a) (1 - Exp[u/2]))

a = 200;
u = 4;
FindMaximum[{fk[a, b, u, x], x > 0}, {x, 1/a^2}, {b, 100 *a}]

(*Limiting behaviour is somewhat different from what we expected and \
not very intuitive to understand at first glance... BUT this looks a \
lot better than everything i've had so far.*)

(*Now lets have a look at the approximate behaviour of k for \
x\[Rule]oo and x\[Rule]0.*)

(*Therefore for x\[Rule]oo collect the terms with largest exponent \
from numerator and denominator of k*)

klargex = 
 Simplify[((1 + a x + E^u (-1 + 3 a x)) (-1 + 3 b x + 
       E^u (1 + b x)))/(-1 + (4 - 3 a + b) x + (2 a - 2 b + 
        3 a b) x^2 + 
     E^(2 u) (-1 + (4 + a - 3 b) x + 3 (a (-2 + b) + 2 b) x^2) + 
     2 E^u (1 + (-4 + a + b) x + (2 a - 2 b + 5 a b) x^2))]

Collect[((1 + a x + E^u (-1 + 3 a x)) (-1 + 3 b x + E^u (1 + b x))), x]

Collect[(-1 + (4 - 3 a + b) x + (2 a - 2 b + 3 a b) x^2 + 
   E^(2 u) (-1 + (4 + a - 3 b) x + 3 (a (-2 + b) + 2 b) x^2) + 
   2 E^u (1 + (-4 + a + b) x + (2 a - 2 b + 5 a b) x^2)), x]

(*Then, from each collect the leading terms in x and simplify*)

fklargex[a_, b_, u_, x_] := 
 Simplify[(-1 + 2 E^u - E^(
     2 u) + (-a + 3 b - 2 a E^u - 2 b E^u + 3 a E^(2 u) - 
        b E^(2 u)) x + (3 a b + 10 a b E^u + 
        3 a b E^(2 u)) x^2)/(-1 + 2 E^u - E^(
     2 u) + (4 - 3 a + b + 
        2 (-4 + a + b) E^u + (4 + a - 3 b) E^(2 u)) x + (2 a - 2 b + 
        3 a b + 2 (2 a - 2 b + 5 a b) E^u + 
        3 (a (-2 + b) + 2 b) E^(2 u)) x^2)]

(*For x\[Rule]0 do taylor expansion*)

ksmallx = Simplify[Series[k, {x, 0, 2}]]

fksmallx[a_, b_, u_, x_] := (b - b E^u + a (-1 - 2 b + E^u))/(
  2 (b - b E^u + a (-1 - b + E^u))) + ((a - b)^2 (-1 + E^u)^2 x)/(
  4 (a (1 + b - E^u) + b (-1 + E^u))^2) + 
  1/(24 (b - b E^u + a (-1 - b + E^u))^3) (a - b)^2 E^-u (-1 + E^
     u)^2 (-2 a^4 b (1 + b - E^u) - 
     a^3 b (-5 + b^2 + 6 E^u - E^(2 u) + 2 b (-3 + E^u)) + 
     b (-1 + E^u) (-E^u + 3 b^2 (-1 + E^u)) - 
     a^2 b (-4 b (-1 + E^u) + 3 (-1 + E^u)^2 + b^2 (-5 + 2 E^u)) - 
     a (4 b E^u - E^u (-1 + E^u) + b^3 (7 - 8 E^u + E^(2 u)))) x^2

lvalues = {2, 5, 10}
resolution = 100
tab1 = Table[0, {k, 1, 4}, {i, 1, resolution + 1}, {l, 1, 2}];
tab2 = Table[0, {k, 1, 4}, {i, 1, resolution + 1}, {l, 1, 2}];
tab3 = Table[0, {k, 1, 4}, {i, 1, resolution + 1}, {l, 1, 2}];
For[i = 1, i <= 3, i++,
 g = 1;
 t = lvalues[[i]];
 Print[t];
 a = 1 + t;
 b = 1 + (g + 1) t;
 u = -10;
 dr = 0.02;
 rmin = -2;
 rmax = 4;
 tab1[[i, All, All]] = 
  Table[N[{10^r, fk[a, b, u, 10^-r]/klim0[a,b,u]}], {r, rmin, 
    rmax, (rmax - rmin)/resolution}];
 tab2[[i, All, All]] = 
  Table[N[{10^r, fksmallx[a, b, u, 10^-r]/klim0[a,b,u]}], {r, rmin, 
    rmax, (rmax - rmin)/resolution}];
 tab3[[i, All, All]] = 
  Table[N[{10^r, fklargex[a, b, u, 10^-r]/klim0[a,b,u]}], {r, rmin, 
    rmax, (rmax - rmin)/resolution}];
 ]
Clear[a, b, u, dr, rmin, rmax, r1, r2, g, t];
For[i = 1, i <= 3, i++,
 t = lvalues[[i]];
 nfile1 = "arate" <> ToString[t] <> ".tsv";
 nfile2 = "alrate" <> ToString[t] <> ".tsv";
 nfile3 = "asrate" <> ToString[t] <> ".tsv";
 Export[nfile1, tab1[[i, All, All]], "TSV"];
 Export[nfile2, tab2[[i, All, All]], "TSV"];
 Export[nfile3, tab3[[i, All, All]], "TSV"];
 ]

tab1 = Table[0, {k, 1, 4}, {i, 1, resolution + 1}, {l, 1, 2}];
tab2 = Table[0, {k, 1, 4}, {i, 1, resolution + 1}, {l, 1, 2}];
tab3 = Table[0, {k, 1, 4}, {i, 1, resolution + 1}, {l, 1, 2}];

For[i = 1, i <= 3, i++,
 t = lvalues[[i]];
 g = 1;
 Print[t];
 a = 1 + t;
 b = 1 + (g + 1) t;
 u = 10;
 dr = 0.02;
 rmin = -2;
 rmax = 4;
 tab1[[i, All, All]] = 
  Table[N[{10^r, fk[a, b, u, 10^-r]}]/klim0[a,b,u], {r, rmin, 
    rmax, (rmax - rmin)/resolution}];
 tab2[[i, All, All]] = 
  Table[N[{10^r, fksmallx[a, b, u, 10^-r]}]/klim0[a,b,u], {r, rmin, 
    rmax, (rmax - rmin)/resolution}];
 tab3[[i, All, All]] = 
  Table[N[{10^r, fklargex[a, b, u, 10^-r]}]/klim0[a,b,u], {r, rmin, 
    rmax, (rmax - rmin)/resolution}];
 ]
Clear[a, b, u, dr, rmin, rmax, r1, r2, g, t];
For[i = 1, i <= 3, i++,
 t = lvalues[[i]];
 nfile1 = "rrate" <> ToString[t] <> ".tsv";
 nfile2 = "rlrate" <> ToString[t] <> ".tsv";
 nfile3 = "rsrate" <> ToString[t] <> ".tsv";
 Export[nfile1, tab1[[i, All, All]], "TSV"];
 Export[nfile2, tab2[[i, All, All]], "TSV"];
 Export[nfile3, tab3[[i, All, All]], "TSV"];
 ]
