#!/bin/bash

# 🚀 Script Setup per Mac - Flashcard Arabo-Italiano
# Autore: Creato per il progetto di insegnamento italiano
# Uso: bash setup-project.sh

set -e  # Interrompe lo script se c'è un errore

# Colori per output più carino
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Funzione per stampare con colori
print_colored() {
    echo -e "${2}${1}${NC}"
}

# Banner di benvenuto
clear
print_colored "╔════════════════════════════════════════════════════════════╗" $CYAN
print_colored "║                    📚 FLASHCARD SETUP                     ║" $CYAN  
print_colored "║              Progetto Arabo-Italiano per Mac               ║" $CYAN
print_colored "╚════════════════════════════════════════════════════════════╝" $CYAN
echo ""

# Controlla se siamo nella directory corretta (dovrebbe essere il repo clonato)
if [ ! -d ".git" ]; then
    print_colored "⚠️  ATTENZIONE: Non sei nella directory del repository!" $RED
    print_colored "Assicurati di essere nella cartella del progetto clonato da GitHub." $YELLOW
    read -p "Vuoi continuare comunque? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_colored "❌ Setup annullato." $RED
        exit 1
    fi
fi

print_colored "🔍 Controllo prerequisiti..." $BLUE

# Controlla se Node.js è installato
if ! command -v node &> /dev/null; then
    print_colored "❌ Node.js non trovato!" $RED
    print_colored "Installa Node.js da: https://nodejs.org/" $YELLOW
    exit 1
else
    NODE_VERSION=$(node --version)
    print_colored "✅ Node.js trovato: $NODE_VERSION" $GREEN
fi

# Controlla se npm è installato
if ! command -v npm &> /dev/null; then
    print_colored "❌ npm non trovato!" $RED
    exit 1
else
    NPM_VERSION=$(npm --version)
    print_colored "✅ npm trovato: $NPM_VERSION" $GREEN
fi

echo ""
print_colored "🚀 Inizio creazione struttura progetto..." $BLUE
echo ""

# Funzione per creare directory con feedback
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        print_colored "📁 Creata: $1" $YELLOW
    else
        print_colored "📁 Esistente: $1" $CYAN
    fi
}

# Funzione per creare file con feedback
create_file() {
    if [ ! -f "$1" ]; then
        touch "$1"
        print_colored "📄 Creato: $1" $GREEN
    else
        print_colored "📄 Esistente: $1" $CYAN
    fi
}

# Array delle directory da creare
directories=(
    "public/assets/audio/beginner/identity"
    "public/assets/audio/beginner/family"
    "public/assets/audio/beginner/colors"
    "public/assets/audio/beginner/numbers"
    "public/assets/audio/beginner/basic-verbs"
    "public/assets/audio/intermediate/past-tense"
    "public/assets/audio/intermediate/future-tense"
    "public/assets/audio/intermediate/complex-sentences"
    "public/assets/audio/intermediate/prepositions"
    "public/assets/audio/advanced/subjunctive"
    "public/assets/audio/advanced/conditional"
    "public/assets/audio/advanced/business"
    "public/assets/audio/advanced/literature"
    "public/assets/images/concepts"
    "public/assets/images/situations"
    "public/assets/images/grammar-illustrations"
    "src/components/flashcards"
    "src/components/ui"
    "src/components/navigation"
    "src/data/levels"
    "src/data/topics"
    "src/data/types"
    "src/utils"
    "src/contexts"
    "src/hooks"
    "src/pages"
    "src/styles"
    "config"
    "docs"
)

# Crea tutte le directory
print_colored "📁 Creazione directory..." $PURPLE
for dir in "${directories[@]}"; do
    create_dir "$dir"
done

# Array dei file da creare
files=(
    # File di configurazione
    "config/levels.config.js"
    "config/topics.config.js"
    "config/flashcard-types.config.js"
    
    # Componenti flashcard
    "src/components/flashcards/BaseFlashcard.js"
    "src/components/flashcards/IdentityFlashcard.js"
    "src/components/flashcards/GrammarFlashcard.js"
    "src/components/flashcards/ConversationFlashcard.js"
    "src/components/flashcards/VerbConjugationFlashcard.js"
    "src/components/flashcards/SituationFlashcard.js"
    
    # Componenti UI
    "src/components/ui/LevelSelector.js"
    "src/components/ui/TopicSelector.js"
    "src/components/ui/ProgressTracker.js"
    "src/components/ui/DifficultyBadge.js"
    "src/components/ui/StudySessionSummary.js"
    
    # Componenti navigazione
    "src/components/navigation/MainNav.js"
    "src/components/navigation/BreadcrumbNav.js"
    "src/components/navigation/CardNavigation.js"
    
    # File dati
    "src/data/levels/beginner.js"
    "src/data/levels/intermediate.js"
    "src/data/levels/advanced.js"
    "src/data/topics/identity.js"
    "src/data/topics/family.js"
    "src/data/topics/colors.js"
    "src/data/topics/verbs.js"
    "src/data/topics/grammar.js"
    "src/data/topics/situations.js"
    "src/data/types/vocabulary.js"
    "src/data/types/grammar.js"
    "src/data/types/conversation.js"
    "src/data/types/exercises.js"
    "src/data/index.js"
    
    # Utility
    "src/utils/flashcardFactory.js"
    "src/utils/progressManager.js"
    "src/utils/difficultyCalculator.js"
    "src/utils/studyPathManager.js"
    
    # Contexts
    "src/contexts/LevelContext.js"
    "src/contexts/ProgressContext.js"
    "src/contexts/SettingsContext.js"
    
    # Hooks
    "src/hooks/useFlashcardType.js"
    "src/hooks/useStudyProgress.js"
    "src/hooks/useAdaptiveLearning.js"
    "src/hooks/useLevelProgression.js"
    
    # Pagine
    "src/pages/HomePage.js"
    "src/pages/LevelSelection.js"
    "src/pages/TopicSelection.js"
    "src/pages/StudySession.js"
    "src/pages/ProgressDashboard.js"
    "src/pages/Settings.js"
    
    # Stili
    "src/styles/App.css"
    "src/styles/Flashcard.css"
    "src/styles/Components.css"
    "src/styles/globals.css"
    
    # Documentazione
    "docs/SETUP.md"
    "docs/DEPLOYMENT.md"
    "docs/CONTRIBUTING.md"
    
    # Altri file
    ".env.example"
    "LICENSE"
)

# Crea tutti i file
echo ""
print_colored "📄 Creazione file template..." $PURPLE
for file in "${files[@]}"; do
    create_file "$file"
done

# Crea .gitignore se non esiste
if [ ! -f ".gitignore" ]; then
    print_colored "📄 Creazione .gitignore..." $GREEN
    cat > .gitignore << 'EOF'
# Dependencies
node_modules/
/.pnp
.pnp.js

# Testing
/coverage

# Production
/build

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*

# IDEs
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Audio files temporanei
/temp-audio/
/audio-temp/

# Build tools
.cache/
.parcel-cache/
EOF
else
    print_colored "📄 Esistente: .gitignore" $CYAN
fi

# Crea package.json se non esiste
if [ ! -f "package.json" ]; then
    print_colored "📦 Creazione package.json..." $GREEN
    cat > package.json << 'EOF'
{
  "name": "flashcard-arabo-italiano",
  "version": "1.0.0",
  "description": "App di flashcard multi-livello per insegnare l'italiano a studenti arabi",
  "homepage": "https://tuonome.github.io/flashcard-arabo-italiano",
  "private": false,
  "dependencies": {
    "@testing-library/jest-dom": "^5.16.4",
    "@testing-library/react": "^13.3.0",
    "@testing-library/user-event": "^13.5.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-scripts": "5.0.1",
    "web-vitals": "^2.1.4"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject",
    "setup": "bash setup-project.sh",
    "predeploy": "npm run build",
    "deploy": "gh-pages -d build"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  },
  "devDependencies": {
    "gh-pages": "^4.0.0"
  },
  "keywords": [
    "flashcard",
    "italiano",
    "arabo",
    "educazione",
    "react",
    "insegnamento"
  ],
  "author": "Il tuo nome",
  "license": "MIT"
}
EOF
else
    print_colored "📦 Esistente: package.json" $CYAN
fi

# Crea README.md se non esiste o aggiornalo
print_colored "📖 Creazione README.md..." $GREEN
cat > README.md << 'EOF'
# 📚 Flashcard Arabo-Italiano

App interattiva multi-livello per insegnare l'italiano a studenti arabi attraverso flashcard animate con audio.

![Flashcard Demo](https://img.shields.io/badge/Status-In%20Development-yellow)
![React](https://img.shields.io/badge/React-18.2.0-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Caratteristiche

- 🔄 **Animazioni fluide** di flip delle carte
- 🔊 **Audio di pronuncia** italiana professionale
- 📱 **Design responsive** (mobile e desktop)
- 🎯 **Interfaccia in arabo** per studenti madrelingua
- 📊 **Tracciamento del progresso** personalizzato
- 🎨 **Design moderno** e intuitivo
- 🎓 **Multi-livello** (Principiante, Intermedio, Avanzato)

## 🚀 Demo Live

[Prova l'app qui](https://tuonome.github.io/flashcard-arabo-italiano) *(sostituisci con il tuo username GitHub)*

## 🛠️ Installazione Locale

```bash
# Clona il repository
git clone https://github.com/tuonome/flashcard-arabo-italiano.git

# Entra nella directory
cd flashcard-arabo-italiano

# Installa le dipendenze
npm install

# Avvia il server di sviluppo
npm start
```

## 📁 Struttura del Progetto

```
flashcard-arabo-italiano/
├── 📁 public/assets/
│   ├── 🔊 audio/          # File audio MP3 per pronuncia
│   └── 🖼️ images/         # Immagini e icone
├── 📁 src/
│   ├── 🧩 components/     # Componenti React riutilizzabili
│   ├── 📊 data/          # Contenuti organizzati per livello
│   ├── 🛠️ utils/         # Funzioni di utilità
│   └── 🎣 hooks/         # Custom React hooks
├── 📁 config/            # Configurazioni per livelli e tipologie
└── 📁 docs/             # Documentazione del progetto
```

## 🎯 Tipologie di Flashcard

### 🎯 Vocabolario
Flashcard tradizionali con immagine, testo arabo e audio italiano.

### 📚 Grammatica
Regole grammaticali con esempi pratici e spiegazioni dettagliate.

### 💬 Conversazione
Dialoghi interattivi con contesto situazionale realistico.

### 🔀 Coniugazione Verbi
Tabelle complete di coniugazione verbale con audio.

### 🎭 Situazioni
Scenari realistici con scelte multiple e feedback.

## 🎓 Livelli di Apprendimento

- **🟢 Principiante** (A1-A2): Identità, famiglia, numeri, colori
- **🟡 Intermedio** (B1-B2): Tempi verbali, frasi complesse
- **🔴 Avanzato** (C1-C2): Congiuntivo, italiano business, letteratura

## 📖 Come Aggiungere Nuovo Contenuto

### Aggiungere Vocabolario
1. Apri `src/data/topics/[argomento].js`
2. Aggiungi nuove entry seguendo il formato esistente
3. Carica i file audio corrispondenti in `public/assets/audio/`

### Creare Nuovi Livelli
1. Crea file in `src/data/levels/`
2. Aggiorna `config/levels.config.js`
3. Implementa logica specifica se necessaria

## 🎵 Gestione File Audio

### Formato Audio Supportato
- **Formato**: MP3
- **Qualità**: 128kbps (bilanciamento qualità/dimensione)
- **Durata**: 2-4 secondi per parola, 5-10 per frasi

### Convenzioni Naming
```
[livello]/[argomento]/[frase-con-trattini].mp3

Esempi:
beginner/identity/io-sono-palestinese.mp3
intermediate/verbs/ho-mangiato-una-mela.mp3
```

### Strumenti Consigliati
- **Registrazione**: Audacity (gratuito)
- **TTS**: Google Text-to-Speech, Amazon Polly
- **Conversione**: Online Audio Converter

## 🚀 Deployment

### GitHub Pages
```bash
npm run build
npm run deploy
```

### Vercel (Consigliato)
1. Collega il repository a Vercel
2. Deploy automatico ad ogni push
3. Preview per ogni Pull Request

## 🤝 Contribuire al Progetto

1. Fork del repository
2. Crea un branch per la tua feature: `git checkout -b feature/nuova-funzionalita`
3. Commit delle modifiche: `git commit -m 'Aggiungi nuova funzionalità'`
4. Push del branch: `git push origin feature/nuova-funzionalita`
5. Apri una Pull Request

Leggi [CONTRIBUTING.md](docs/CONTRIBUTING.md) per le linee guida dettagliate.

## 📄 Licenza

Questo progetto è rilasciato sotto licenza MIT. Vedi [LICENSE](LICENSE) per i dettagli.

## 🙏 Ringraziamenti

- Creato con ❤️ per studenti arabi che imparano l'italiano
- Font arabi grazie a [Google Fonts Cairo](https://fonts.google.com/specimen/Cairo)
- Ispirato dalle metodologie di insegnamento L2 moderne

## 📞 Contatti

- **Autore**: [Il tuo nome]
- **Email**: [tua.email@esempio.com]
- **LinkedIn**: [Il tuo profilo LinkedIn]

---

⭐ Se questo progetto ti è utile, lascia una stella su GitHub!
EOF

echo ""
print_colored "🎉 SETUP COMPLETATO CON SUCCESSO!" $GREEN
echo ""
print_colored "📊 Statistiche:" $CYAN
print_colored "   📁 Directory create: ${#directories[@]}" $YELLOW
print_colored "   📄 File template creati: ${#files[@]}" $YELLOW
print_colored "   📦 File configurazione: 3" $YELLOW
echo ""
print_colored "📋 PROSSIMI PASSI:" $BLUE
print_colored "1. 🔊 Aggiungi i file audio nella cartella public/assets/audio/" $YELLOW
print_colored "2. ⚙️  Modifica i file di configurazione in config/" $YELLOW
print_colored "3. 🧩 Implementa i componenti partendo da BaseFlashcard.js" $YELLOW
print_colored "4. 📦 Installa le dipendenze: npm install" $YELLOW
print_colored "5. 🚀 Avvia il progetto: npm start" $YELLOW
print_colored "6. 🌐 Testa in VS Code con Live Server" $YELLOW
echo ""
print_colored "💡 SUGGERIMENTI:" $PURPLE
print_colored "   • Usa il terminale integrato di VS Code (Cmd+`)" $CYAN
print_colored "   • Installa l'estensione 'ES7+ React/Redux/React-Native snippets'" $CYAN
print_colored "   • Configura Prettier per formattazione automatica" $CYAN
echo ""
print_colored "🎯 Il tuo progetto è pronto per lo sviluppo!" $GREEN

# Chiede se vuoi installare le dipendenze npm
echo ""
read -p "Vuoi installare subito le dipendenze npm? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_colored "📦 Installazione dipendenze npm..." $BLUE
    npm install
    print_colored "✅ Dipendenze installate con successo!" $GREEN
    echo ""
    print_colored "🚀 Puoi ora avviare il progetto con: npm start" $GREEN
fi

print_colored "✨ Happy coding! ✨" $PURPLE