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

um[r_] := 0.5*(u1[r]+u2[r])

Kd = NIntegrate[Exp[um[r]]/(r^2),{r,Rsink,Rmax}]^(-1)

Print[Kd]
