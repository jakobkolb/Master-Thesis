(*KT and diffusion constant are set to one*)
KT = 1;
d = 1;
RSink = 1;
W = {{-w12, w21}, {w12, -w21}};
EvecWtmp = {{w21/w12, 1}, {-1, 1}};
stmp = Transpose[{Normalize[EvecWtmp[[1]]], 
    Normalize[EvecWtmp[[2]]]}] ;
invstmp = Simplify[Assuming[{w12 > 0, w21 > 0}, Inverse[stmp]]];
DiagW = Simplify[invstmp.W.stmp];
BCu = {{Exp[u1/kt], 0}, {0, Exp[u2/kt]}};
(*Time scale of switching is given by \[Alpha], ratio of rates is \
given by \[Beta] to simplify system of linear equations*)
(* \[Alpha] \
is basically the sum of the eigenvalues divided by D *)
(* \[Beta] is \
the ratio between the eigenvalues -does not matter if divided by D \
since they cancel out! *)
DiagW = DiagW /. -w12 - w21 -> \[Alpha]
EvecW = EvecWtmp /. w21/w12 -> \[Beta]
s = Transpose[{Normalize[EvecW[[1]]], Normalize[EvecW[[2]]]}] 
invs = Simplify[Assuming[{w12 > 0, w21 > 0}, Inverse[s]]]


BCu = {{Exp[u1/KT], 0}, {0, Exp[u2/KT]}};

rhodash[r_] = {{1, 1/r, 0, 0}, {0, 0, 
   Exp[-Sqrt[Abs[DiagW[[2, 2]]]/d] r]/r, 
   Exp[Sqrt[Abs[DiagW[[2, 2]]]/d] r]/r}} 


(* These are the "NEW" boundary conditions *)

lgs1 = Join[
   4 \[Pi] RSink^2 rhodash'[RSink] - 
    kReact rhodash[RSink], {{0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 
     0, 0, 0}}, 2];
(* This was the old boundary condition *)
(*lgs1 = \
Join[rhodash[RSink],{{0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0}},2];*)

lgs2 = Join[
   rhodash[a], -invs.BCu.s.rhodash[a], {{0, 0, 0, 0}, {0, 0, 0, 0}}, 
   2];
lgs3 = Join[rhodash'[a], -rhodash'[a], {{0, 0, 0, 0}, {0, 0, 0, 0}}, 
   2];
lgs4 = Join[{{0, 0, 0, 0}, {0, 0, 0, 0}}, 
   invs.BCu.s.rhodash[b], -rhodash[b], 2];
lgs5 = Join[{{0, 0, 0, 0}, {0, 0, 0, 0}}, rhodash'[b], -rhodash'[b], 
   2];
lgs6 = Join[{{0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0}}, {{1,
      0, 0, 0}, {0, 0, 0, Infinity}}, 2];
lgs = Join[lgs1, lgs2, lgs3, lgs4, lgs5, lgs6, 1];
lgs = lgs[[1 ;; 11, 1 ;; 11]]

c = TimeConstrained[
   Assuming[{w12 > 0 && w21 > 0 && d > 0 && KT > 0 && 
      b > a > RSink > 0 && kReact > 0}, 
    LinearSolve[lgs, Transpose[{{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}}]]],
    Infinity];


c = Join[c, {{0}}];

rhodash1[r_] = rhodash[r].c[[1 ;; 4]];
rhodash2[r_] = rhodash[r].c[[5 ;; 8]];
rhodash3[r_] = rhodash[r].Simplify[c[[9 ;; 12]], TimeConstraint -> Infinity];
n = Limit[Total[Total[s.rhodash3[r]]], r -> Infinity]
(*Calculate density profiles*)
rho1[r_] = s.rhodash1[r]/n;
rho2[r_] = s.rhodash2[r]/n;
rho3[r_] = s.rhodash3[r]/n;
(*Calculate mean density profiles*)

rhom1[r_] = Part[rho1[r], 1] + Part[rho1[r], 2];
rhom2[r_] = Part[rho2[r], 1] + Part[rho2[r], 2];
rhom3[r_] = Part[rho3[r], 1] + Part[rho3[r], 2];
(* Calculate absorption rate,this is just kReact x rho[RSink] for \
this problem, as deduced from B.C. *)

Directory[]

Clear[u1, u2, \[Alpha], \[Beta], a, b, kReact]
ktmp =  Total[rhom1'[RSink]];
Put[ktmp, "non_simplified_ratev1.tmp"]

k = Simplify[ktmp, TimeConstraint -> Infinity]
k >> "simplified_ratev1.tmp"
k 
