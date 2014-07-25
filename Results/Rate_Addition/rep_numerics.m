 
Clear["Global`*"]

d = 1;
U01 = 3;
U02 = 0;
a = 8.5;
b = 2.5;
at = a - b;
bt = a + b;
n = 64;
Ksvalues={0.1,1,10}
Rsink = 1;
Rmax = 30;
t0 = 0;
t1 = 1000;
rdmin = -3;
rdmax = 3;
datapoints = 24;
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
     w21 \[Rho]2[r, t] + w12 \[Rho]1[r, t]
   };
bc = {
   \[Rho]1[Rsink, t]*Ks == D[\[Rho]1[r,t],r]/.r->Rsink,
   \[Rho]2[Rsink, t]*Ks == D[\[Rho]2[r,t],r]/.r->Rsink,
   \[Rho]1[Rmax, t] == w21/(w12 + w21),
   \[Rho]2[Rmax, t] == w12/(w12 + w21)
   };
ic = {
   \[Rho]1[r, t0] == w21/(w12 + w21)*(1 - 1/r),
   \[Rho]2[r, t0] == w12/(w12 + w21)*(1 - 1/r)
   };

Densities = 
  Table[0, {k, 1, 3}, {i, 1, datapoints + 1}, {j, 1, 3 + 1}];
ReactionRate = 
  Table[0, {k, 1, 2}, {i, 1, datapoints + 1}, {j, 1, 3 + 1}];

For[j = 1, j <= 3, j++,
 Ks = Ksvalues[[j]];
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
  
  Densities[[1, i + 1, j ]] = \[Rho]1eq[r];
  Densities[[2, i + 1, j ]] = \[Rho]2eq[r];
  Densities[[3, i + 1, j ]] = \[Rho]tot[r];
  ReactionRate[[1, i + 1, j ]] = rd;
  ReactionRate[[2, i + 1, j ]] = D[\[Rho]tot[r], r] /. r -> Rsink;
  ]]

b = Table[0, {i, 1, npoints + 1}];
b[[1]] = N[ReactionRate[[1, All, 1]]];
For[j = 1, j <= npoints, j++,
 b[[j + 1]] = N[Flatten[ReactionRate[[2, All, j]]]];
 ]
Export["rep_numeric_rates.csv", Transpose[b]];
