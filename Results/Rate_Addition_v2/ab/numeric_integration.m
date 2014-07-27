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
bc1 = {
   \[Rho]1[Rsink, t]*Ks == 0,
   \[Rho]2[Rsink, t]*Ks == 0,
   \[Rho]1[Rmax, t] == w21/(w12 + w21),
   \[Rho]2[Rmax, t] == w12/(w12 + w21)
   };
bc2 = {
   \[Rho]1[Rsink, t]*Ks == Derivative[1,0][\[Rho]1][Rsink,t],
   \[Rho]2[Rsink, t]*Ks == Derivative[1,0][\[Rho]2][Rsink,t],
   \[Rho]1[Rmax, t] == w21/(w12 + w21),
   \[Rho]2[Rmax, t] == w12/(w12 + w21)
   };
ic = {
   \[Rho]1[r, t0] == w21/(w12 + w21)*Exp[-((r - Rmax)/(Rmax/4))^n],
   \[Rho]2[r, t0] == w12/(w12 + w21)*Exp[-((r - Rmax)/(Rmax/4))^n]
   };

Print[Length[rdvalues]]
Print[Length[Ksvalues]]

Kvalues = Table[0,{i,1,Length[rdvalues]},{i,1,Length[Ksvalues]+1}]

For[i=1,i<=Length[Ksvalues],i++,
For[j=1,j<=Length[rdvalues],j++,
ClearAll[rhoon, rhoof,rhovals, w21, w12, sol, Ks, rd, \[Rho]1eq, \[Rho]2eq, \[Rho]tot];
Ks = Ksvalues[[i]];
rd = rdvalues[[j]];
w21 = d/(2*rd^2);
w12 = w21;
sol = NDSolve[{pde, bc2, ic}, {\[Rho]1, \[Rho]2}, {t, t1, t1}, {r, 
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
     Rmax, (Rmax - Rsink)/resolution}]], 3];

Export["rhovals"<>ToString[i]<>".tsv", N[rhovals], "TSV"];

rhooff = 
 Partition[
  Flatten[Table[N[{r, \[Rho]2eq[r]}], {r, Rsink, 
     Rmax, (Rmax - Rsink)/resolution}]], 2];


Export["offrhovals"<>ToString[i]<>".tsv", N[rhooff], "TSV"];

rhoon = 
 Partition[
  Flatten[Table[N[{r, \[Rho]1eq[r]}], {r, Rsink, 
     Rmax, (Rmax - Rsink)/resolution}]], 2];

Export["onrhovals"<>ToString[i]<>".tsv", N[rhoon], "TSV"];

PutAppend[{D[\[Rho]1eq[r], r] /. r -> Rsink,\[Rho]1eq[r]*Ks /. r -> Rsink, Ks, Ksvalues[[i]]}, "rate.out"];
PutAppend[{D[\[Rho]2eq[r], r] /. r -> Rsink,\[Rho]2eq[r]*Ks /. r -> Rsink, Ks, Ksvalues[[i]]}, "rate.out"];
Kvalues[[j,1]] = N[rd];
Kvalues[[j,1+i]] = Flatten[N[\[Rho]tot[Rsink]*Ks]];
]]
Export["rateoutput.tsv",Kvalues,"TSV"]
For[i=1,i<=Length[rdvalues],i++,
PutAppend[Flatten[Kvalues[[i,All]]],"test.out"]
]

