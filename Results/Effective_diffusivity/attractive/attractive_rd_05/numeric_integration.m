Clear["Global`*"]
SetSystemOptions["CatchMachineUnderflow" -> False]
<<input.py

Print[U01, U02, a, b, n, Rsink, Rmax, rd]

a = Rsink+l;
b = Rsink+l+l*g

at = a + (b-a)/2
bt = (b-a)/2;

Print[a]
Print[b]
Print[at]
Print[bt]

npoints = nmax - nmin;

u1[r_] := U01 Exp[-((r - at)/bt)^n];
u2[r_] := U02 Exp[-((r - at)/bt)^n];
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
   \[Rho]1[Rsink, t] == 0,
   \[Rho]2[Rsink, t] == 0,
   \[Rho]1[Rmax, t] == w21/(w12 + w21),
   \[Rho]2[Rmax, t] == w12/(w12 + w21)
   };
ic = {
   \[Rho]1[r, t0] == w21/(w12 + w21)*(1 - 1/r),
   \[Rho]2[r, t0] == w12/(w12 + w21)*(1 - 1/r)
   };


w21 = d/(2*rd^2);
w12 = w21;
sol = NDSolve[{pde, bc, ic}, {\[Rho]1, \[Rho]2}, {t, t1, t1}, {r, 
    Rsink, Rmax}, MaxSteps -> Infinity, MaxStepFraction -> 0.002, 
   AccuracyGoal -> 15, StartingStepSize -> 0.001, 
   Method -> {"MethodOfLines", 
     "SpatialDiscretization" -> {"TensorProductGrid", 
       "MinPoints" -> 24000}}];
\[Rho]1eq[r_] = \[Rho]1[r, t1] /. sol;
\[Rho]2eq[r_] = \[Rho]2[r, t1] /. sol;
\[Rho]tot[r_] = (\[Rho]1[r, t1] + \[Rho]2[r, t1]) /. sol;

rhovals = 
 Partition[
  Flatten[Table[N[{r, \[Rho]tot[r], (u1[r]+u2[r])/2}], {r, Rsink, 
     Rmax, (Rmax - Rsink)/resolution}]], 3]

Export["rhovals.tsv", N[rhovals], "TSV"]

rhooff = 
 Partition[
  Flatten[Table[{r, \[Rho]2eq[r]}, {r, Rsink, 
     Rmax, (Rmax - Rsink)/resolution}]], 3]


Export["offrhovals.tsv", N[rhovals], "TSV"]

rhoon = 
 Partition[
  Flatten[Table[{r, \[Rho]1eq[r]}, {r, Rsink, 
     Rmax, (Rmax - Rsink)/resolution}]], 3]

Export["onrhovals.tsv", N[rhovals], "TSV"]
