import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import os
import glob

file = "../PGUIADA_MN2/EExpl/eulex_results_g025.dat"
dades = np.loadtxt(file) # Dades extretes resoltes pel mètode d'Euler Explícit

ntemps, npos = dades.shape # Dimensions matriu (tremps x posició)
recorregut = 2.0 # 2,0 cm entre plaques

x = np.linspace(0, recorregut, npos)

fig, ax = plt.subplots() # Creem figura i eixos de l'animació
line, = ax.plot([],[]) # Creació gràfic, comença buit, les dades s'aniràn actualizant a cada frame

ax.set_xlim(0,recorregut) # Límit eix x (posició)
ax.set_ylim(np.min(dades), np.max(dades)) # Límit eix y (Temperatura)
ax.set_xlabel('Posició (cm)')
ax.set_ylabel('Temperatura (Cº)')
 
def init():
    line.set_data([],[])
    return line,

# Funció que actualitza a cada frame les dades
def update(frame): 
    y = dades[frame,:]  
    line.set_data(x,y)
    return line,

# creem l'animació 
anim = animation.FuncAnimation(fig, update, frames = ntemps, init_func = init, blit= True, interval = 20)

anim.save('Anim/animacio_temperatura.gif', writer='pillow', fps=30)

for frame_file in glob.glob("frame*.png"): # Per eliminar tots els archius de frames (ja que es guardaven tots)
    os.remove(frame_file)

print("l'animació s'ha desat a la carpeta Anim, amb el nom de animacio_temperatura")