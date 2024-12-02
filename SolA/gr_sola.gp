set terminal pngcairo enhanced size 800,600 font "Arial,12"
set output 'sol_analitica.png'
set title "Temperatura vs. Posició al temps final t=0.025s"
set ylabel "Temperatura (ºC)"
set xlabel "Posició (cm)"
set xrange[0:2]
set yrange[0:60]
set grid
set key inside bottom right # Posició de la llegenda

# Línies verticals
set arrow from 1.25, graph 0 to 1.25, graph 1 nohead lt 2 lw 1 lc rgb "black"
set arrow from 0.75, graph 0 to 0.75, graph 1 nohead lt 2 lw 1 lc rgb "black"
# Línies horitzontals
set arrow from graph 0, first 50 to graph 1, first 50 nohead lt 2 lw 1 lc rgb "red"

# Llegenda
plot "resultats.dat" with lines title "Solució analítica", \
     1/0 lc rgb "black" lw 1 title "Límits del teixit (0.75 cm - 1.25 cm)", \
     1/0 lc rgb "red" lw 1 title "Temperatura mínima (50 ºC)"

set output