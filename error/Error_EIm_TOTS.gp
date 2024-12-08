set terminal pngcairo enhanced size 1500,1080 font "Cambria,28"
set output 'Error_EIm_TOTS.png'
set ylabel "Error (ºC)"
set xlabel "Posició (cm)"
set xrange[0:2]
set yrange[0:1]
set format x "%.1f"
set format y "%.2f"
set grid
set key at screen 0.7300, 0.8900 center font "Cambria, 20" # Posició de la llegenda

# Línies verticals
set arrow from 1.25, graph 0 to 1.25, graph 1 nohead lt 2 lw 1 lc rgb "black"
set arrow from 0.75, graph 0 to 0.75, graph 1 nohead lt 2 lw 1 lc rgb "black"
set format x "%.1f"
set format y "%.1f"
# Llegenda
plot "Error_EIm_103.dat" with lines lc rgb "red" lw 2 title "Relació mallats = 1", \
     "Error_EIm_0503.dat" with lines lc rgb "blue" lw 2 title "Relació mallats = 0.5", \
    1/0 lc rgb "black" lw 1 title "Límits del teixit (0.75 cm - 1.25 cm)"


set output