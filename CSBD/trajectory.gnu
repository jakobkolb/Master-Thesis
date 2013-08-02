set term gif animate delay 30 size 400, 400
set output "point.gif"
do for [n=1:100] {
    splot [0:10][0:10][0:10] "trajectory.out" u 2:3:4 every :::::n w p t sprintf("n=%i", n)
}
