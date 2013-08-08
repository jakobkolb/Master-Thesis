set term postscript eps enhanced colour
set output "dens_plot.eps"

set title "steady state density profile"
set yrange [0:0.0014]
set xlabel "distance from sink"
set ylabel  "particle density"
set key right bottom

f1(x) = a1*(1 - 2/x) 
fit f1(x) "dens_data.out" u 1:2 every ::5:0::0 via a1

f2(x) = a2*(1 - 3/x) 
fit f2(x) "dens_data.out" u 1:2 every ::5:1::1 via a2

f3(x) = a3*(1 - 4/x) 
fit f3(x) "dens_data.out" u 1:2 every ::5:2::2 via a3

f4(x) = a4*(1 - 5/x) 
fit f4(x) "dens_data.out" u 1:2 every ::5:3::3 via a4

plot    "dens_data.out" u 1:2:3 every :::0::0 with yerrorbars ps .3 lw 0.1 lt rgb 'red' title "data",\
        a1*(1-2/x) lw 0.2 lt rgb 'red' title sprintf("rhoinf = %.5f", a1),\
        "dens_data.out" u 1:2:3 every :::1::1 with yerrorbars ps .3 lw 0.1 lt rgb 'green' title "data",\
        a2*(1-3/x) lw 0.2 lt rgb 'green' title sprintf("rhoinf = %.5f", a2),\
        "dens_data.out" u 1:2:3 every :::2::2 with yerrorbars ps .3 lw 0.1 lt rgb 'blue' title "data",\
        a3*(1-4/x) lw 0.2 lt rgb 'blue' title sprintf("rhoinf = %.5f", a3),\
        "dens_data.out" u 1:2:3 every :::3::3 with yerrorbars ps .3 lw 0.1 lt rgb 'black' title "data",\
        a4*(1-5/x) lw 0.2 lt rgb 'black' title sprintf("rhoinf = %.5f", a4)


