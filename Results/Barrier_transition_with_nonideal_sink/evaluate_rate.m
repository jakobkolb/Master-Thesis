rate[u1_,u2_,a_,b_,\[Alpha]_,\[Beta]_,kReact_]=Get["simplified_rate.m"];

l=5
g=1
rSink=1

a = rSink+l;
b = a+l*g;

resolution = 100;
wmin = -3;
wmax = 2;
w21 = 1;
umin = -4;
umax = 4;
u2=0;
kReact = 0.1;
usteps = (umax-umin)/2

rateT = Table[0,{i,1,usteps+2}];
rateT[[1]]=Table[N[10^w12],{w12, wmin, wmax, (wmax - wmin)/resolution}];


For[i = 0, i <= usteps, i++,
    (* List of instructions *)
    u1 = umin+2*i+0.01;
    Print[i+2, u1];
    rateT[[i+2]] = Table[N[rate[u1,u2,a,b,Abs[-10^w12-w21],w21/10^w12,kReact]],{w12, wmin, wmax, (wmax - wmin)/resolution}];    
    ]
Export["rate_data.tsv",Transpose[rateT],"TSV"]

(* Table[N[10^w12],{w12, wmin, wmax, (wmax - wmin)/resolution}];
Table[N[rate[u1,u2,a,b,Abs[-10^w12-w21],w21/10^w12,kReact]],{w12, wmin, wmax, (wmax - wmin)/resolution}]*)

