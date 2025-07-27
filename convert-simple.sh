#!/bin/bash

# 🎵 Script semplice per convertire MP3 in subdirectory "converted"

set -e

# Colori
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_colored() {
    echo -e "${2}${1}${NC}"
}

print_colored "🎵 Convertitore MP3 Semplice" $BLUE
echo ""

# Controlla ffmpeg
if ! command -v ffmpeg &> /dev/null; then
    print_colored "❌ FFmpeg non trovato! Installa con: brew install ffmpeg" $RED
    exit 1
fi

# Directory di lavoro
AUDIO_DIR="public/assets/audio"

if [[ ! -d "$AUDIO_DIR" ]]; then
    print_colored "❌ Directory $AUDIO_DIR non trovata!" $RED
    exit 1
fi

print_colored "📁 Cerco file MP3 in: $AUDIO_DIR" $BLUE
echo ""

# Trova e converte tutti i file MP3
find "$AUDIO_DIR" -name "*.mp3" -type f | while read -r mp3_file; do
    # Ottieni la directory del file
    file_dir=$(dirname "$mp3_file")
    # Nome del file senza percorso
    filename=$(basename "$mp3_file")
    # Directory converted
    converted_dir="$file_dir/converted"
    # File di output
    output_file="$converted_dir/$filename"
    
    print_colored "🔄 Conversione: $mp3_file" $YELLOW
    
    # Crea directory converted se non esiste
    mkdir -p "$converted_dir"
    
    # Converti il file
    if ffmpeg -i "$mp3_file" \
        -codec:a libmp3lame \
        -b:a 128k \
        -ar 44100 \
        -ac 2 \
        -y \
        "$output_file" \
        -loglevel error; then
        
        print_colored "  ✅ Salvato in: $output_file" $GREEN
        
        # Mostra dimensioni
        original_size=$(stat -f%z "$mp3_file" 2>/dev/null || stat -c%s "$mp3_file" 2>/dev/null)
        new_size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null)
        
        if [[ -n "$original_size" && -n "$new_size" ]]; then
            original_kb=$((original_size / 1024))
            new_kb=$((new_size / 1024))
            print_colored "  📊 ${original_kb}KB → ${new_kb}KB" $BLUE
        fi
    else
        print_colored "  ❌ Errore nella conversione" $RED
    fi
    
    echo ""
done

print_colored "🎉 Conversione completata!" $GREEN
print_colored "📁 File convertiti salvati nelle directory /converted/" $BLUE
echo ""
print_colored "📋 Per usare i file convertiti:" $YELLOW
print_colored "1. Testa un file convertito rinominandolo" $YELLOW
print_colored "2. Se funziona, sostituisci tutti gli originali" $YELLOW
print_colored "   find public/assets/audio -name converted -type d -exec cp {}/* {}/.. \\;" $BLUE