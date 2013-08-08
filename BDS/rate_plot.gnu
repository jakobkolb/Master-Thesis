set term postscript eps enhanced colour
set output "rate_plot.eps"

set title "Absorption rate of sink depending on sink size"
set xlabel "sink size"
set ylabel  "absorption rate"


plot "rate_data.out" u 1:2 every ::2 title "measured rate", "rate_data.out" u 1:3 every ::2 title "rate from /inf density"

