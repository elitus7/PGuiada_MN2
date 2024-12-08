set terminal pngcairo enhanced size 1500,1080 font "Cambria,30"
set output 'eexp_tfinal_g051.png'

set ylabel "Temperatura (ºC)"
set xlabel "Posició (cm)"
set xrange[0:2]
set yrange[-6000:6000]
set grid
set key at screen 0.7575, 0.2 center font "Cambria, 20"

# Línies verticals
set arrow from 1.25, graph 0 to 1.25, graph 1 nohead lt 2 lw 1 lc rgb "black"
set arrow from 0.75, graph 0 to 0.75, graph 1 nohead lt 2 lw 1 lc rgb "black"
# Línies horitzontals
set arrow from graph 0, first 50 to graph 1, first 50 nohead lt 2 lw 1 lc rgb "red"
set format x "%.1f"
# Llegenda
plot "eulex_results_f_g051.dat" with lines title "Euler Explícit", \
     1/0 lc rgb "black" lw 1 title "Límits del teixit (0.75 cm - 1.25 cm)", \
     1/0 lc rgb "red" lw 1 title "Temperatura mínima (50 ºC)"
set output

set output