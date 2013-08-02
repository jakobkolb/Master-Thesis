set term postscript eps enhanced colour
set output "test.eps"

plot "system_state.out" every:::0::0 u 2:3 w points,\
     "system_state.out" every:::1::1 u 2:3 w points
