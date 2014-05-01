rate[u1_,u2_,a_,b_,\[Alpha]_,\[Beta]_,kReact_]=Get["short_rate.m"];

u1 = -4
u2 = 1

a = 2
b = 20

DGstar = 1000;
v0 = 500;
TLCS = 300;
DS = -50;
v0Trans = 10;
DGthermo[T_] := DS (T - TLCS);
DGkinetic = 1000;
resolution = 20

rateT = Table[{0,0},{i,1,resolution}];

For[i = 1, i <= resolution, i++,
    (* List of instructions *)
    T = 270 + i*3;
    kReact = v0 Exp[-DGstar / T];
    k12 = v0Trans Exp[-(DGthermo[T] + DGkinetic)/T];
    k21 = v0Trans Exp[-(DGkinetic)/T];
    \[Alpha] = k12+k21;
    \[Beta] = k21/k12;
    rateT[[i]] = N[{1/T,rate[u1,u2,a,b,\[Alpha],\[Beta],kReact],kReact}]
    ]
Export["rate_data.tsv",rateT,"TSV"]
