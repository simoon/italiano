import os
from PIL import Image

# Ottieni la directory dove si trova questo script
cartella_corrente = os.path.dirname(os.path.abspath(__file__))

# Cicla tutti i file nella directory corrente
for filename in os.listdir(cartella_corrente):
    if filename.lower().endswith(".png"):
        percorso_png = os.path.join(cartella_corrente, filename)

        # Rimuove l'estensione e crea il nome file con .jpg
        nome_base = os.path.splitext(filename)[0]
        percorso_jpg = os.path.join(cartella_corrente, nome_base + ".jpg")

        # Apre e converte l'immagine
        with Image.open(percorso_png) as img:
            img_rgb = img.convert("RGB")  # Necessario per salvare come JPEG
            img_rgb.save(percorso_jpg, "JPEG")

print("Conversione completata.")
