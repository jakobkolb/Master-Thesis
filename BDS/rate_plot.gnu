set term postscript eps enhanced colour
set output "rate_plot.eps"

set title "Absorption rate of sink depending on sink size"
set xlabel "sink size"
set ylabel  "absorption rate"
set xrange [0:]

plot "rate_data.out" u 1:2:3 every ::2 with yerrorbars title "measured rate", "rate_data.out" u 1:2:3 every ::3 with yerrorbars title "rate from density on boundary"

