# 📚 Flashcard Arabo-Italiano

App interattiva multi-livello per insegnare l'italiano a studenti arabi attraverso flashcard animate con audio.

![Flashcard Demo](https://img.shields.io/badge/Status-In%20Development-yellow)
![React](https://img.shields.io/badge/React-18.2.0-blue)
![License](https://img.shields.io/badge/License-MIT-green)
Audio: https://ttsmp3.com/text-to-speech/Italian/

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
