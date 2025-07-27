#!/bin/bash

# 🎵 Script per convertire MP3 in formato web-compatibile
# Usa FFmpeg per ricodificare tutti i file MP3 nella directory audio

set -e

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_colored() {
    echo -e "${2}${1}${NC}"
}

# Banner
print_colored "🎵 CONVERTITORE MP3 PER FLASHCARD" $BLUE
print_colored "Converte tutti i file MP3 in formato web-compatibile" $YELLOW
echo ""

# Controlla se ffmpeg è installato
if ! command -v ffmpeg &> /dev/null; then
    print_colored "❌ FFmpeg non trovato!" $RED
    print_colored "Installa FFmpeg:" $YELLOW
    print_colored "  • Mac: brew install ffmpeg" $YELLOW
    print_colored "  • Ubuntu: sudo apt install ffmpeg" $YELLOW
    print_colored "  • Windows: Scarica da https://ffmpeg.org/" $YELLOW
    exit 1
fi

print_colored "✅ FFmpeg trovato: $(ffmpeg -version | head -n1)" $GREEN
echo ""

# Directory di input e output
INPUT_DIR="public/assets/audio"
OUTPUT_DIR="public/assets/audio/converted"
BACKUP_DIR="public/assets/audio/backup"

# Crea directory se non esistono
mkdir -p "$OUTPUT_DIR"
mkdir -p "$BACKUP_DIR"

print_colored "📁 Directory input: $INPUT_DIR" $BLUE
print_colored "📁 Directory output: $OUTPUT_DIR" $BLUE
print_colored "📁 Directory backup: $BACKUP_DIR" $BLUE
echo ""

# Contatori
total_files=0
converted_files=0
failed_files=0

# Funzione per convertire un singolo file
convert_file() {
    local input_file="$1"
    local relative_path="$2"
    local output_file="$OUTPUT_DIR/$relative_path"
    local backup_file="$BACKUP_DIR/$relative_path"
    
    # Crea directory di output se non esiste
    mkdir -p "$(dirname "$output_file")"
    mkdir -p "$(dirname "$backup_file")"
    
    print_colored "🔄 Conversione: $relative_path" $YELLOW
    
    # Backup del file originale
    cp "$input_file" "$backup_file"
    
    # Converte il file con impostazioni ottimizzate per il web
    if ffmpeg -i "$input_file" \
        -codec:a libmp3lame \
        -b:a 128k \
        -ar 44100 \
        -ac 2 \
        -f mp3 \
        -y \
        "$output_file" \
        -loglevel error; then
        
        print_colored "  ✅ Convertito con successo" $GREEN
        ((converted_files++))
        
        # Mostra info sul file
        original_size=$(stat -f%z "$input_file" 2>/dev/null || stat -c%s "$input_file" 2>/dev/null || echo "N/A")
        new_size=$(stat -f%z "$output_file" 2>/dev/null || stat -c%s "$output_file" 2>/dev/null || echo "N/A")
        
        if [[ "$original_size" != "N/A" && "$new_size" != "N/A" ]]; then
            original_kb=$((original_size / 1024))
            new_kb=$((new_size / 1024))
            print_colored "  📊 Dimensione: ${original_kb}KB → ${new_kb}KB" $BLUE
        fi
    else
        print_colored "  ❌ Errore nella conversione" $RED
        ((failed_files++))
    fi
    
    echo ""
}

# Trova tutti i file MP3
print_colored "🔍 Ricerca file MP3..." $BLUE

if [[ ! -d "$INPUT_DIR" ]]; then
    print_colored "❌ Directory $INPUT_DIR non trovata!" $RED
    exit 1
fi

# Array per raccogliere tutti i file MP3
mp3_files=()
while IFS= read -r -d '' file; do
    mp3_files+=("$file")
done < <(find "$INPUT_DIR" -name "*.mp3" -type f -print0)

total_files=${#mp3_files[@]}

if [[ $total_files -eq 0 ]]; then
    print_colored "⚠️ Nessun file MP3 trovato in $INPUT_DIR" $YELLOW
    exit 0
fi

print_colored "📊 Trovati $total_files file MP3" $GREEN
echo ""

# Chiede conferma
read -p "Vuoi procedere con la conversione? (y/n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_colored "❌ Conversione annullata" $RED
    exit 0
fi

echo ""
print_colored "🚀 Inizio conversione..." $GREEN
echo ""

# Converte tutti i file
for file in "${mp3_files[@]}"; do
    ((total_files++))
    relative_path="${file#$INPUT_DIR/}"
    convert_file "$file" "$relative_path"
done

# Statistiche finali
echo ""
print_colored "📊 CONVERSIONE COMPLETATA!" $GREEN
print_colored "✅ File convertiti: $converted_files" $GREEN
print_colored "❌ File falliti: $failed_files" $RED
print_colored "📁 File originali salvati in: $BACKUP_DIR" $BLUE
print_colored "📁 File convertiti salvati in: $OUTPUT_DIR" $BLUE
echo ""

# Suggerimenti per sostituire i file
if [[ $converted_files -gt 0 ]]; then
    print_colored "🔄 PER USARE I FILE CONVERTITI:" $YELLOW
    print_colored "1. Sostituisci i file originali:" $YELLOW
    print_colored "   cp -r $OUTPUT_DIR/* $INPUT_DIR/" $BLUE
    print_colored "2. Oppure aggiorna i percorsi nel codice per usare /converted/" $YELLOW
    echo ""
    
    read -p "Vuoi sostituire automaticamente i file originali? (y/n): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_colored "🔄 Sostituzione file originali..." $YELLOW
        cp -r "$OUTPUT_DIR"/* "$INPUT_DIR/"
        print_colored "✅ File sostituiti con successo!" $GREEN
        print_colored "🗑️ Puoi ora eliminare la cartella converted se vuoi" $BLUE
    fi
fi

print_colored "🎉 Processo completato!" $GREEN