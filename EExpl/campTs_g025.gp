set terminal pngcairo enhanced size 800,600 font "Cambria,12"
set output 'campTs_g025.png'
set title "Temperatura vs. Posició i Temps amb Relació de Mallats 0.25"
set ylabel "Temps (s)"
set xlabel "Posició (cm)"
set label 1 center rotate at screen 0.97,0.5 "Temperatura (ºC)" #Etiqueta rotada
set xrange[0:2]
set yrange[0:71]

#set key inside top right # Posició de la llegenda

# Línies verticals
#set arrow from 1.25, graph 0 to 1.25, graph 1 nohead lt 2 lw 1 lc rgb "black"
#set arrow from 0.75, graph 0 to 0.75, graph 1 nohead lt 2 lw 1 lc rgb "black"

# Gràfic amb llegenda
plot "eulex_results_g025.dat" u (0.02*$1):(6.96894825E-02*$2):3 matrix with image title "Temperatura", \
#     1/0 lc rgb "black" lw 1 title "Límits del teixit (0.75 cm - 1.25 cm)"

set output