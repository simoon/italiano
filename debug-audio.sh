#!/bin/bash

# 🔍 Script di debug completo per file audio

# Colori
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

print_colored() {
    echo -e "${2}${1}${NC}"
}

print_colored "🔍 DEBUG AUDIO COMPLETO" $BLUE
echo ""

# File da testare
TEST_FILE="public/assets/audio/beginner/identity/tu-sei-italiano.mp3"

if [[ ! -f "$TEST_FILE" ]]; then
    print_colored "❌ File non trovato: $TEST_FILE" $RED
    exit 1
fi

print_colored "📁 Analizzando: $TEST_FILE" $BLUE
echo ""

# 1. Info basiche del file
print_colored "1. INFORMAZIONI BASE DEL FILE:" $YELLOW
ls -la "$TEST_FILE"
file "$TEST_FILE"
echo ""

# 2. Info dettagliate con ffprobe
print_colored "2. ANALISI FFPROBE:" $YELLOW
if command -v ffprobe &> /dev/null; then
    ffprobe -v error -show_format -show_streams "$TEST_FILE"
else
    print_colored "⚠️ ffprobe non disponibile" $YELLOW
fi
echo ""

# 3. Test headers HTTP
print_colored "3. TEST HEADERS HTTP:" $YELLOW
# Avvia server temporaneo se non è già attivo
if ! curl -s "http://localhost:3000" > /dev/null 2>&1; then
    print_colored "⚠️ Server non attivo, avvia con 'npm start'" $YELLOW
else
    print_colored "✅ Server attivo" $GREEN
    echo ""
    print_colored "Headers per il file:" $BLUE
    curl -I "http://localhost:3000/assets/audio/beginner/identity/tu-sei-italiano.mp3" 2>/dev/null
fi
echo ""

# 4. Test di accessibilità HTTP
print_colored "4. TEST ACCESSIBILITÀ HTTP:" $YELLOW
if curl -s "http://localhost:3000" > /dev/null 2>&1; then
    response=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:3000/assets/audio/beginner/identity/tu-sei-italiano.mp3")
    print_colored "Codice risposta HTTP: $response" $BLUE
    
    if [[ "$response" == "200" ]]; then
        print_colored "✅ File accessibile via HTTP" $GREEN
    else
        print_colored "❌ File NON accessibile via HTTP" $RED
    fi
fi
echo ""

# 5. Verifica MIME type
print_colored "5. VERIFICA MIME TYPE:" $YELLOW
if command -v file &> /dev/null; then
    mime_type=$(file -b --mime-type "$TEST_FILE")
    print_colored "MIME type: $mime_type" $BLUE
    
    if [[ "$mime_type" == "audio/mpeg" ]]; then
        print_colored "✅ MIME type corretto" $GREEN
    else
        print_colored "⚠️ MIME type inaspettato" $YELLOW
    fi
fi
echo ""

# 6. Test con browser (simulazione)
print_colored "6. TEST COMPATIBILITÀ BROWSER:" $YELLOW
print_colored "Crea un file HTML di test..." $BLUE

cat > /tmp/audio_test.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Test Audio</title>
</head>
<body>
    <h1>Test Audio Debug</h1>
    <audio controls>
        <source src="http://localhost:3000/assets/audio/beginner/identity/tu-sei-italiano.mp3" type="audio/mpeg">
        Il tuo browser non supporta l'audio.
    </audio>
    
    <script>
        const audio = new Audio('http://localhost:3000/assets/audio/beginner/identity/tu-sei-italiano.mp3');
        
        audio.addEventListener('loadstart', () => console.log('✅ loadstart'));
        audio.addEventListener('loadeddata', () => console.log('✅ loadeddata'));
        audio.addEventListener('canplay', () => console.log('✅ canplay'));
        audio.addEventListener('error', (e) => {
            console.error('❌ Errore audio:', e);
            console.error('❌ Codice errore:', e.target.error.code);
            console.error('❌ Messaggio:', e.target.error.message);
        });
        
        // Test immediato
        audio.load();
    </script>
</body>
</html>
EOF

print_colored "File di test creato: /tmp/audio_test.html" $GREEN
print_colored "Apri questo file nel browser per test dettagliato" $YELLOW
echo ""

# 7. Converte un file di test
print_colored "7. CONVERSIONE FILE DI TEST:" $YELLOW
test_converted="/tmp/tu-sei-italiano-test.mp3"

if command -v ffmpeg &> /dev/null; then
    print_colored "Conversione con impostazioni ultra-compatibili..." $BLUE
    
    if ffmpeg -i "$TEST_FILE" \
        -codec:a libmp3lame \
        -b:a 96k \
        -ar 22050 \
        -ac 1 \
        -f mp3 \
        -y \
        "$test_converted" \
        -loglevel error; then
        
        print_colored "✅ File convertito: $test_converted" $GREEN
        print_colored "Dimensioni:" $BLUE
        ls -la "$test_converted"
        
        print_colored "Info file convertito:" $BLUE
        file "$test_converted"
    else
        print_colored "❌ Errore nella conversione" $RED
    fi
else
    print_colored "⚠️ ffmpeg non disponibile" $YELLOW
fi
echo ""

# 8. Suggerimenti
print_colored "8. SUGGERIMENTI DEBUG:" $YELLOW
print_colored "• Apri /tmp/audio_test.html nel browser" $BLUE
print_colored "• Controlla la console del browser (F12)" $BLUE
print_colored "• Verifica che npm start sia attivo" $BLUE
print_colored "• Prova a sostituire il file con quello convertito in /tmp/" $BLUE
echo ""

print_colored "🎯 Per sostituire con il file di test:" $GREEN
print_colored "cp $test_converted $TEST_FILE" $BLUE