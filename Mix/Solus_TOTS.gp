set terminal pngcairo enhanced size 1500,1080 font "Cambria,28"
set output 'Solus_TOTS.png'
set ylabel "Temperatura (ºC)"
set xlabel "Posició (cm)"
set xrange[0:2]
set yrange[0:60]
set format x "%.1f"
set grid
set key at screen 0.7300, 0.2500 center font "Cambria, 20" # Posició de la llegenda

# Línies verticals
set arrow from 1.25, graph 0 to 1.25, graph 1 nohead lt 2 lw 1 lc rgb "black"
set arrow from 0.75, graph 0 to 0.75, graph 1 nohead lt 2 lw 1 lc rgb "black"

# Llegenda
plot "resultats.dat" with lines lc rgb "purple" lw 2 title "Analítica", \
     "eulex_results_f_g025.dat" with lines lc rgb "blue" lw 2 title "Euler explícit 0.25", \
     "Resultats_CN05_025.dat" using 2:1 with lines lc rgb "green" lw 2 title "Crank-Nicolson 0.5", \
     "Resultats_Eulimp_05.dat" using 2:1 with lines lc rgb "red" lw 2 title "Euler implícit 0.5", \
    1/0 lc rgb "black" lw 1 title "Límits del teixit (0.75 cm - 1.25 cm)"


set output