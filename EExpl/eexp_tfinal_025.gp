set terminal pngcairo enhanced size 800,600 font "Arial,12"
set output 'eexp_tfinal_g025.png'
set title "Temperatura vs. Posició per t_a = 0.025"
set ylabel "Temperatura (ºC)"
set xlabel "Posició (cm)"
set xrange[0:2]
set yrange[0:60]
set grid
plot "eulex_results_f.dat" with lines 
set output