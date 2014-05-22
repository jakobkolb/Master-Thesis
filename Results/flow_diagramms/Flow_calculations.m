Clear[s, invs, g, x, u, d, rs, a, b, rho, rho1, rho2, rho3, rhodash, \
rhodash1, rhodash2, rhodash3, lgs, lgs1, lgs2, lgs3, lgs4, lgs5, lgs6]

w = {{-g, g}, {g, -g}};

Eigenvectors[w] ;
evec = {{1, 1}, {-1, 1}};

s = Transpose[{Normalize[evec[[1]]], Normalize[evec[[2]]]}] ;

invs = Simplify[Assuming[{ab > 0, ba > 0}, Inverse[s]]];

diagw = Simplify[invs.w.s];

bcu = {{1, 0}, {0, Exp[u]}};

rhodash[r_] = {{1, 1/r, 0, 0}, {0, 0, 
     Exp[-Sqrt[Abs[diagw[[2, 2]]]/d] r]/r, 
     Exp[Sqrt[Abs[diagw[[2, 2]]]/d] r]/r}} /. 
   Sqrt[2] Sqrt[1/d] Sqrt[Abs[g]] -> x;

lgs1 = Join[
   rhodash[rs], {{0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0}}, 
   2];
lgs2 = Join[
   rhodash[a], -invs.bcu.s.rhodash[a], {{0, 0, 0, 0}, {0, 0, 0, 0}}, 
   2];
lgs3 = Join[rhodash'[a], -rhodash'[a], {{0, 0, 0, 0}, {0, 0, 0, 0}}, 
   2];
lgs4 = Join[{{0, 0, 0, 0}, {0, 0, 0, 0}}, 
   invs.bcu.s.rhodash[b], -rhodash[b], 2];
lgs5 = Join[{{0, 0, 0, 0}, {0, 0, 0, 0}}, rhodash'[b], -rhodash'[b], 
   2];
lgs6 = Join[{{0, 0, 0, 0, 0, 0, 0, 0}, {0, 0, 0, 0, 0, 0, 0, 0}}, {{1,
      0, 0, 0}, {0, 0, 0, Infinity}}, 2];

lgs = Join[lgs1, lgs2, lgs3, lgs4, lgs5, lgs6, 1];

lgs = lgs[[1 ;; 11, 1 ;; 11]];

c = Assuming[{ab > 0, ba > 0, d > 0, kt > 0, b > a > rs > 0}, 
   LinearSolve[lgs, Transpose[{{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}}]]];

c = Assuming[b > a > rs > 0, Simplify[c]];

c = Join[c, {{0}}];

rhodash1[r_] = rhodash[r].c[[1 ;; 4]];
rhodash2[r_] = rhodash[r].c[[5 ;; 8]];
rhodash3[r_] = rhodash[r].c[[9 ;; 12]];

rho1[r_] = s.rhodash1[r];
rho2[r_] = s.rhodash2[r];
rho3[r_] = s.rhodash3[r];

n = Limit[Part[rho3[r], 1] + Part[rho3[r], 2], {r -> Infinity}]

rhom1[r_] = (Part[rho1[r], 1] + Part[rho1[r], 2])/n;
rhom2[r_] = (Part[rho2[r], 1] + Part[rho2[r], 2])/n;
rhom3[r_] = (Part[rho3[r], 1] + Part[rho3[r], 2])/n;

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
     2 E^(2 u + 3 a x + b x) x (2 + a^2 x + b x - a (1 + x)));

rho1[2]


Jr1[r1_, r2_] := 4 Pi NIntegrate[rho1[r] w r^2, {r, r1, r2}]
Js1[r_] := 4 Pi r^2 D[rho1[rdash], rdash] /. rdash -> r
Jr2[r1_, r2_] := 4 Pi  NIntegrate[rho2[r] w r^2, {r, r1, r2}]
Js2[r_] := 4 Pi  r^2 D[rho2[rdash], rdash] /. rdash -> r
Jr3[r1_, r2_] := 4 Pi  NIntegrate[rho3[r] w r^2, {r, r1, r2}]
Js3[r_] := 4 Pi  r^2 D[rho3[rdash], rdash] /. rdash -> r

xvals = {0.04, 0.4, 4}
t = 5;
g = 1;
a = 1 + t;
b = 1 + (g + 1) t;
rs = 1.0;
rd = 30;
u = 10;
dr = 0.01;

For[i = 1, i < 4, i++,
 
 x = xvals[[i]];
 w = x^2/2;
 
 filename1 = "Sflows0" <> ToString[i] <> ".tsv";
 filename2 = "Rflows0" <> ToString[i] <> ".tsv";
 dfilename = "dens0" <> ToString[i] <> ".tsv";
 Sfile = OpenAppend[filename1];
 Rfile = OpenAppend[filename2];
 dfile = OpenAppend[dfilename];
 
 Export[Rfile, Jr1[rs, a][[1]] - Jr1[rs, a][[2]], "TSV"];
 Export[Rfile, "\n", "TSV"];
 Export[Rfile, Jr2[a, b][[1]] - Jr2[a, b][[2]], "TSV"];
 Export[Rfile, "\n", "TSV"];
 Export[Rfile, Jr3[b, rd][[1]] - Jr3[b, rd][[2]], "TSV"];
 Export[Sfile, Transpose[Js1[rs]], "TSV"];
 Export[Sfile, "\n", "TSV"];
 Export[Sfile, Transpose[Js2[a]], "TSV"];
 Export[Sfile, "\n", "TSV"];
 Export[Sfile, Transpose[Js3[b]], "TSV"];
 Export[Sfile, "\n", "TSV"];
 Export[Sfile, Transpose[Js3[rd]], "TSV"];
 Export[Sfile, "\n", "TSV"];
 
 tab1 = Table[Flatten[{{r}, rho1[r], rhom1[r]}], {r, rs, a, dr}];
 tab2 = Table[Flatten[{{r}, rho2[r], rhom2[r]}], {r, a, b, dr}];
 tab3 = Table[Flatten[{{r}, rho3[r], rhom3[r]}], {r, b, rd, dr}];
 tab1[[All, 2]] = tab1[[All, 2]]/Last[tab3][[2]];
 tab1[[All, 3]] = tab1[[All, 3]]/Last[tab3][[3]];
 tab1[[All, 4]] = tab1[[All, 4]]/Last[tab3][[4]];
 tab2[[All, 2]] = tab2[[All, 2]]/Last[tab3][[2]];
 tab2[[All, 3]] = tab2[[All, 3]]/Last[tab3][[3]];
 tab2[[All, 4]] = tab2[[All, 4]]/Last[tab3][[4]];
 tab3[[All, 2]] = tab3[[All, 2]]/Last[tab3][[2]];
 tab3[[All, 3]] = tab3[[All, 3]]/Last[tab3][[3]];
 tab3[[All, 4]] = tab3[[All, 4]]/Last[tab3][[4]];
 Last[tab3][[2]];
 Export[dfile, tab1, "TSV"];
 Export[dfile, "\n", "TSV"];
 Export[dfile, tab2, "TSV"];
 Export[dfile, "\n", "TSV"];
 Export[dfile, tab3, "TSV"];
 Export[dfile, "\n", "TSV"];
 
 Close[filename1];
 Close[filename2];
 Close[dfilename];
 ]
