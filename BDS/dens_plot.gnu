set term postscript eps enhanced colour
set output "dens_plot.eps"

set title "steady state density profile"
set xlabel "distance from sink"
set ylabel  "particle density"
unset key

plot "dens_data.out" i 0 u 1:2:3 with yerrorbars ps .1 lt rgb 'red', "dens_data.out" i 0 u 1:2 with lines lt rgb 'red', \
     "dens_data.out" i 1 u 1:2:3 with yerrorbars ps .1 lt rgb 'green', "dens_data.out" i 1 u 1:2 with lines lt rgb 'green', \
     "dens_data.out" i 2 u 1:2:3 with yerrorbars ps .1 lt rgb 'black', "dens_data.out" i 2 u 1:2 with lines lt rgb 'black', \
     "dens_data.out" i 3 u 1:2:3 with yerrorbars ps .1 lt rgb 'blue', "dens_data.out" i 3 u 1:2 with lines lt rgb 'blue'
