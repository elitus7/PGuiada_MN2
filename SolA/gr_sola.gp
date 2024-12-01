set terminal pngcairo enhanced size 800,600 font "Arial,12"
set output 'sol_analitica.png'
set title "Temperatura vs. Posició al temps final t=0.025s"
set ylabel "Temperatura (ºC)"
set xlabel "Posició (cm)"
set xrange[0:2]
set yrange[0:60]
plot "resultats.dat" with lines
set output