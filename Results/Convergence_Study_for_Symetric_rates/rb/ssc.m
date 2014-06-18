 
fk[a_, b_, rd_, rmax_, 
  u_] := ((a (b (-3 E^((2 (1 + a + b))/rd) + 3 E^((2 (2 a + b))/rd) - 
            E^((2 (a + 2 b))/rd) + E^((2 + 4 b)/rd) + 
            E^((2 (1 + a + rmax))/rd) - E^((2 (2 a + rmax))/rd) - 
            3 E^((2 (1 + b + rmax))/rd) + 
            3 E^((2 (a + b + rmax))/rd) - 
            3 E^((2 (1 + a + b + rd u))/rd) - 
            E^((2 (2 a + b + rd u))/rd) + 
            3 E^((2 (a + 2 b + rd u))/rd) - 
            10 E^((2 + 2 a + 2 b + rd u)/rd) - 
            2 E^((4 a + 2 b + rd u)/rd) - 2 E^((2 + 4 b + rd u)/rd) - 
            2 E^((2 a + 4 b + rd u)/rd) - 
            3 E^((2 (1 + a + rmax + rd u))/rd) - 
            E^((2 (2 a + rmax + rd u))/rd) + 
            E^((2 (1 + b + rmax + rd u))/rd) + 
            3 E^((2 (a + b + rmax + rd u))/rd) + 
            2 E^((2 + 2 a + 2 rmax + rd u)/rd) + 
            2 E^((4 a + 2 rmax + rd u)/rd) + 
            2 E^((2 + 2 b + 2 rmax + rd u)/rd) + 
            10 E^((2 a + 2 b + 2 rmax + rd u)/rd) + 
            E^((2 + 4 b + 2 rd u)/rd)) - (E^((2 b)/rd) - 
            E^((2 rmax)/rd)) (-1 + E^u) (E^((4 a)/rd) - 
            E^((2 (1 + a))/rd) - E^((2 (1 + b))/rd) + 
            E^((2 (a + b))/rd) - E^((4 a)/rd + u) - 
            3 E^((2 + 2 a + rd u)/rd) + E^((2 + 2 b + rd u)/rd) + 
            3 E^((2 a + 2 b + rd u)/rd)) rd) + (-E^(2/rd) + 
         E^((2 a)/rd)) (-1 + 
         E^u) (-2 b^2 E^((a + b)/rd) (E^((2 b)/rd) + 
            E^((2 rmax)/rd)) (-1 + E^u) + 
         b (E^((4 b)/rd) + 3 E^((2 (a + b))/rd) - 2 E^((a + 3 b)/rd) -
             E^((2 (a + rmax))/rd) - 3 E^((2 (b + rmax))/rd) + 
            2 E^((a + b + 2 rmax)/rd) - E^((4 b)/rd + u) + 
            E^((2 a + 2 b + rd u)/rd) + 2 E^((a + 3 b + rd u)/rd) + 
            E^((2 a + 2 rmax + rd u)/rd) - 
            2 E^((a + b + 2 rmax + rd u)/rd) - 
            E^((2 b + 2 rmax + rd u)/rd)) rd + (-E^(((2 a)/rd)) + 
            E^((2 b)/rd)) (E^((2 b)/rd) - E^((2 rmax)/rd)) (-1 + 
            E^u) rd^2)) rmax)/(2 a^2 E^((a + b)/rd) (E^(2/rd) + 
       E^((2 a)/rd)) (E^((2 b)/rd) - 
       E^((2 rmax)/rd)) (-1 + E^u)^2 rmax + 
    a (b (E^((2 (a + 2 b))/rd) (1 - 3 rmax) + 
          E^((2 (2 a + b + rd u))/rd) (1 - 3 rmax) + 
          3 E^((2 (1 + a + b))/rd) (1 - rmax) + 
          E^((2 (2 a + rmax))/rd) (1 - rmax) + 
          3 E^((2 (1 + a + b + rd u))/rd) (1 - rmax) + 
          10 E^((2 + 2 a + 2 b + rd u)/rd) (1 - rmax) + 
          2 E^((2 + 4 b + rd u)/rd) (1 - rmax) + 
          E^((2 (2 a + rmax + rd u))/rd) (1 - rmax) + 
          E^((2 (2 a + b))/rd) (-3 + rmax) - 
          E^((2 (1 + b + rmax))/rd) (-3 + rmax) + 
          E^((2 (a + 2 b + rd u))/rd) (-3 + rmax) - 
          E^((2 (1 + a + rmax + rd u))/rd) (-3 + rmax) + 
          E^((2 + 4 b)/rd) (-1 + rmax) + 
          3 E^((2 (a + b + rmax))/rd) (-1 + rmax) + 
          3 E^((2 (a + b + rmax + rd u))/rd) (-1 + rmax) + 
          2 E^((4 a + 2 rmax + rd u)/rd) (-1 + rmax) + 
          10 E^((2 a + 2 b + 2 rmax + rd u)/rd) (-1 + rmax) + 
          E^((2 + 4 b + 2 rd u)/rd) (-1 + rmax) + 
          2 E^((4 a + 2 b + rd u)/rd) (1 + rmax) + 
          2 E^((2 a + 4 b + rd u)/rd) (1 + rmax) - 
          2 E^((2 + 2 a + 2 rmax + rd u)/rd) (1 + rmax) - 
          2 E^((2 + 2 b + 2 rmax + rd u)/rd) (1 + rmax) + 
          E^((2 (1 + a + rmax))/rd) (-1 + 3 rmax) + 
          E^((2 (1 + b + rmax + rd u))/rd) (-1 + 3 rmax)) - (-1 + 
          E^u) (E^((2 + 2 a + 2 b + rd u)/rd) (-rd (-3 + rmax) - 
             6 rmax) + 
          E^((2 (1 + b + rmax))/rd) (rd (-1 + rmax) - 2 rmax) + 
          E^((2 + 4 b)/rd) rd (1 - rmax) + 
          E^((2 a + 4 b + rd u)/rd) rd (-3 + rmax) + 
          E^((2 + 2 a + 2 rmax + rd u)/rd) rd (-3 + rmax) - 
          E^((2 (2 a + rmax))/rd) rd (-1 + rmax) + 
          E^((2 + 4 b + rd u)/rd) rd (-1 + rmax) + 
          E^((4 a + 2 rmax + rd u)/rd) rd (-1 + rmax) + 
          2 E^((2 + a + 3 b)/rd) (-1 + rd) rmax - 
          2 E^((2 + a + b + 2 rmax)/rd) (-1 + rd) rmax - 
          2 E^((2 + a + 3 b + rd u)/rd) (-1 + rd) rmax + 
          2 E^((2 + a + b + 2 rmax + rd u)/rd) (-1 + rd) rmax - 
          2 E^((3 (a + b))/rd) (1 + rd) rmax + 
          2 E^((3 a + b + 2 rmax)/rd) (1 + rd) rmax + 
          2 E^((3 a + 3 b + rd u)/rd) (1 + rd) rmax - 
          2 E^((3 a + b + 2 rmax + rd u)/rd) (1 + rd) rmax + 
          E^((2 (2 a + b))/rd) (rd (-1 + rmax) + 2 rmax) + 
          E^((2 (a + 2 b))/rd) rd (-1 + 3 rmax) + 
          E^((2 (1 + a + rmax))/rd) rd (-1 + 3 rmax) + 
          E^((2 a + 2 b + 2 rmax + rd u)/rd) (-rd (-3 + rmax) + 
             6 rmax) + 
          E^((2 (1 + a + b))/rd) (rd - 2 rmax - 3 rd rmax) + 
          E^((2 (a + b + rmax))/rd) (rd + 2 rmax - 3 rd rmax) + 
          E^((4 a + 2 b + rd u)/rd) (rd - 2 rmax - rd rmax) + 
          E^((2 + 2 b + 2 rmax + rd u)/rd) (rd + 2 rmax - 
             rd rmax))) + (-1 + 
       E^u) (2 b^2 E^((a + b)/rd) (-E^(2/rd) + 
          E^((2 a)/rd)) (E^((2 b)/rd) + E^((2 rmax)/rd)) (-1 + E^u) + 
       b (E^((2 (1 + a + b))/rd) (-rd (-3 + rmax) - 2 rmax) + 
          E^((2 (a + 2 b))/rd) (rd (-1 + rmax) - 2 rmax) + 
          E^((2 + 4 b)/rd) rd (1 - rmax) + 
          2 E^((2 + a + b + 2 rmax)/rd) (rd - rmax) - 
          2 E^((3 a + b + 2 rmax)/rd) (rd - rmax) - 
          2 E^((2 + a + b + 2 rmax + rd u)/rd) (rd - rmax) + 
          2 E^((3 a + b + 2 rmax + rd u)/rd) (rd - rmax) + 
          E^((2 (2 a + b))/rd) rd (-3 + rmax) + 
          E^((2 (1 + b + rmax))/rd) rd (-3 + rmax) - 
          E^((2 (2 a + rmax))/rd) rd (-1 + rmax) + 
          E^((2 + 4 b + rd u)/rd) rd (-1 + rmax) + 
          E^((4 a + 2 rmax + rd u)/rd) rd (-1 + rmax) + 
          2 E^((3 (a + b))/rd) (rd + rmax) - 
          2 E^((2 + a + 3 b)/rd) (rd + rmax) + 
          2 E^((2 + a + 3 b + rd u)/rd) (rd + rmax) - 
          2 E^((3 a + 3 b + rd u)/rd) (rd + rmax) + 
          E^((2 (a + b + rmax))/rd) (-rd (-3 + rmax) + 2 rmax) + 
          E^((2 (1 + a + rmax))/rd) (rd (-1 + rmax) + 2 rmax) + 
          E^((4 a + 2 b + rd u)/rd) rd (-1 + 3 rmax) + 
          E^((2 + 2 b + 2 rmax + rd u)/rd) rd (-1 + 3 rmax) + 
          E^((2 + 2 a + 2 b + rd u)/rd) (rd - 6 rmax - 3 rd rmax) + 
          E^((2 a + 2 b + 2 rmax + rd u)/rd) (rd + 6 rmax - 
             3 rd rmax) + 
          E^((2 + 2 a + 2 rmax + rd u)/rd) (rd - 2 rmax - rd rmax) + 
          E^((2 a + 4 b + rd u)/rd) (rd + 2 rmax - 
             rd rmax)) + (-E^(a/rd) + E^(b/rd)) (-1 + 
          E^u) rd (E^((2 a + 3 b)/rd) (rd (-1 + rmax) - 2 rmax) + 
          E^((2 + b + 2 rmax)/rd) (rd (-1 + rmax) - 2 rmax) + 
          E^((2 + 3 b)/rd) rd (1 - rmax) - 
          E^((3 a + 2 rmax)/rd) rd (-1 + rmax) + 
          E^((3 a + 2 b)/rd) (rd (-1 + rmax) + 2 rmax) + 
          E^((2 + a + 2 rmax)/rd) (rd (-1 + rmax) + 2 rmax) + 
          E^((2 + a + 2 b)/rd) (rd - 4 rmax - rd rmax) + 
          E^((2 a + b + 2 rmax)/rd) (rd + 4 rmax - rd rmax))))

nmin = 1;
nmax = 8;
rdmin = -3;
rdmax = 3;
datapoints = 19;
d = 1;
U01 = 3;
U02 = 0;
a = 8.5;
b = 2.5;
at = a - b;
bt = a + b;
npoints = nmax - nmin;
Rsink = 1;
Rmax = 25;
t0 = 0;
t1 = 5000;
u1[r_] := U01 Exp[-((r - a)/b)^n];
u2[r_] := U02 Exp[-((r - a)/b)^n];
pde = {D[\[Rho]1[r, t], t] == 
    2/r \[Rho]1[r, t] u1'[r] + 
     D[\[Rho]1[r, t], r] u1'[r] + \[Rho]1[r, t] u1''[r] + 
     d 2/r D[\[Rho]1[r, t], r] + d D[\[Rho]1[r, t], r, r] - 
     w12 \[Rho]1[r, t] + w21 \[Rho]2[r, t], 
   D[\[Rho]2[r, t], t] == 
    2/r \[Rho]2[r, t] u2'[r] + 
     D[\[Rho]2[r, t], r] u2'[r] + \[Rho]2[r, t] u2''[r] + 
     d 2/r D[\[Rho]2[r, t], r] + d D[\[Rho]2[r, t], r, r] - 
     w21 \[Rho]2[r, t] + w12 \[Rho]1[r, t]};
bc = {\[Rho]1[Rsink, t] == 0, \[Rho]2[Rsink, t] == 
    0, \[Rho]1[Rmax, t] == w21/(w12 + w21), \[Rho]2[Rmax, t] == 
    w12/(w12 + w21)};
ic = {\[Rho]1[r, t0] == w21/(w12 + w21)*(1 - 1/r), \[Rho]2[r, t0] == 
    w12/(w12 + w21)*(1 - 1/r)};
ReactionRate = 
  Table[0, {k, 1, 2}, {i, 1, datapoints + 1}, {j, 1, npoints + 1}];

For[j = 0, j <= npoints, j++,
 n = 2^(nmin + j);
 For[i = 0, i <= datapoints, i++,
  rd = 10^(rdmin + i*(rdmax - rdmin)/datapoints);
  w21 = d/(2*rd^2);
  w12 = w21;
  sol = NDSolve[{pde, bc, ic}, {\[Rho]1, \[Rho]2}, {t, t1, t1}, {r, 
     Rsink, Rmax}, MaxSteps -> Infinity, MaxStepFraction -> 0.002, 
    AccuracyGoal -> 15, StartingStepSize -> 0.001, 
    WorkingPrecision -> MachinePrecision, 
    Method -> {"MethodOfLines", 
      "SpatialDiscretization" -> {"TensorProductGrid", 
        "MinPoints" -> 24000}}];
  Print["Done", "n=", n, "i=", i, "w12=", N[w12]];
  \[Rho]1eq[r_] = \[Rho]1[r, t1] /. sol;
  \[Rho]2eq[r_] = \[Rho]2[r, t1] /. sol;
  \[Rho]tot[r_] = (\[Rho]1[r, t1] + \[Rho]2[r, t1]) /. sol;
  ReactionRate[[1, i + 1, j + 1]] = rd;
  ReactionRate[[2, i + 1, j + 1]] = D[\[Rho]tot[r], r] /. r -> 1;
  Print[N[D[\[Rho]tot[r], r] /. r -> 1]];
  ]]

c1 = Transpose[{ReactionRate[[1, All, 1]], 
    Flatten[ReactionRate[[2, All, 1]]]}];
c2 = Transpose[{ReactionRate[[1, All, 1]], 
    Flatten[ReactionRate[[2, All, 2]]]}];
c3 = Transpose[{ReactionRate[[1, All, 1]], 
    Flatten[ReactionRate[[2, All, 3]]]}];
p1 = ListLogLinearPlot[{c1, c2, c3}];
p2 = LogLinearPlot[
   fk[at, bt, rd, Rmax, U01], {rd, (10^rdmin), (10^rdmax)}];
Show[p1, p2, PlotRange -> All]


b = Table[0, {i, 1, npoints + 1}];
b[[1]] = N[ReactionRate[[1, All, 1]]];
For[j = 1, j <= npoints, j++,
 b[[j + 1]] = N[Flatten[ReactionRate[[2, All, j]]]];]
Export["numeric_rates.csv", Transpose[b]]

resolution = 500;
c = Table[{N[10^rd], fk[at, bt, 10^rd, Rmax, U01]}, {rd, rdmin, 
    rdmax, (rdmax - rdmin)/resolution}];
Export["analytic_rates.csv", N[c]]
