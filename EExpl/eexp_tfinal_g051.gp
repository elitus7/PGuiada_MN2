set terminal pngcairo enhanced size 800,600 font "Arial,12"
set output 'eexp_tfinal_g051.png'
set title "Temperatura vs. Posició per t_a = 0.025 amb Relació de Mallats 0.51"
set ylabel "Temperatura (ºC)"
set xlabel "Posició (cm)"
set xrange[0:2]
set yrange[-6000:6000]
set grid
plot "eulex_results_f_g051.dat" with lines 
set output