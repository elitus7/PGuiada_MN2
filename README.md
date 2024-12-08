# Pràctica Guiada. Modelització del Tractament d'Ablació Cardíaca IVS
En aquest repositori podeu trobar les implementacions dels diferents mètodes numèrics emprats (amb els seus errors respecte la solució analítica) per a la pràctica sobre la modelització del tractament d'ablació cardíaca IVS, usant Fortran 95 + la generació de les animacions demanades en Python. Tot està organitzat per carpetes. 

Els arxius .f95 (codi en Fortran) s'han de compilar prèviament (usant gfortran o qualsevol altre compilador) abans de poder-los usar. Aquests permeten generar els arxius de resultats .dat. Ajustant els diversos paràmetres del codi (relació de mallats, temps final, etc.) es poden obtenir tots i cadascun dels .dat.

*Nota: Els números g025, g049, g051 pels resultats del mètode d'Euler explícit i 1, 05 pels resultats del mètode d'Euler implícit fan referència a la relació entre mallats espacial i temporal.

Les gràfiques estan fetes amb Gnuplot i es poden trobar a les carpetes dels diferents mètodes en format .png.

També podeu trobar una secció amb la representació de la solució analítica i el codi necessari per generar-la.
