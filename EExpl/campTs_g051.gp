set terminal pngcairo enhanced size 800,600 font "Arial,12"
set output 'campTs_g051.png'

set ylabel "Temps (s)"
set xlabel "Posició (cm)"
set label 1 center rotate at screen 0.97,0.5 "Temperatura (ºC)" #Usem aquesta indicació per col·locar una etiqueta en un punt concret de la imatge. L'1 fa referència a que és l'etiqueta 1.
set xrange[0:2]
set yrange[0:71]
plot "eulex_results_g051.dat" u (0.02*$1):(6.96894825E-02*$2):3 matrix with image #Cal posar el $ per poder multiplicar per valor necessari.
set output

#La solució és inestable, el que es veu no té cap sentit. 