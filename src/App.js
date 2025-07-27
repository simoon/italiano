import React, { useState } from 'react';
import BaseFlashcard from './components/flashcards/BaseFlashcard';
import LessonSelector from './pages/LessonSelector';
import useFlashcard from './hooks/useFlashcard';
import useAudio from './hooks/useAudio';
import { identityVocabulary } from './data/topics/identity';
import './styles/Flashcard.css';

/**
 * Componente principale dell'app Flashcard con navigazione
 */
const App = () => {
  const [currentLesson, setCurrentLesson] = useState(null);
  const [vocabularyData, setVocabularyData] = useState([]);

  // Hook personalizzati per gestire flashcard e audio
  const {
    currentWord,
    isFlipped,
    progress,
    handleFlip,
    handleNext,
    handlePrevious,
    progressText,
    hasCards,
    resetSession
  } = useFlashcard(vocabularyData);

  const { playAudio, isPlaying } = useAudio();

  /**
   * Gestisce la selezione di una lezione
   */
  const handleLessonSelect = (lessonId) => {
    let lessonData = [];
    
    switch (lessonId) {
      case 'identity':
        lessonData = identityVocabulary;
        break;
      case 'family':
        // Per ora vuoto, implementare in futuro
        lessonData = [];
        break;
      case 'colors':
        // Per ora vuoto, implementare in futuro
        lessonData = [];
        break;
      default:
        lessonData = [];
    }
    
    setVocabularyData(lessonData);
    setCurrentLesson(lessonId);
    resetSession(); // Reset dello stato delle flashcard
  };

  /**
   * Torna alla selezione delle lezioni
   */
  const handleBackToLessons = () => {
    setCurrentLesson(null);
    setVocabularyData([]);
  };

  /**
   * Gestisce la riproduzione dell'audio
   */
  const handleAudioPlay = (audioPath) => {
    if (currentWord) {
      playAudio(audioPath, currentWord.italian, 'it-IT');
    }
  };

  // Se non è selezionata nessuna lezione, mostra il selettore
  if (!currentLesson) {
    return <LessonSelector onLessonSelect={handleLessonSelect} />;
  }

  // Se non ci sono carte per la lezione selezionata
  if (!hasCards) {
    return (
      <div className="app">
        <div className="app-header">
          <button 
            className="back-button"
            onClick={handleBackToLessons}
          >
            ← العودة للدروس
          </button>
          <h1 className="lesson-title">
            🇮🇹 من أين أتي؟ 🇸🇦
            <span className="italian-subtitle">Da dove vengo</span>
          </h1>
          <p style={{ color: 'white', fontSize: '1.2rem' }}>
            هذا الدرس غير متوفر حالياً
          </p>
        </div>
      </div>
    );
  }

  // Mostra le flashcard della lezione selezionata
  return (
    <div className="app">
      {/* Header con titolo, bottone indietro e progresso */}
      <header className="app-header">
        <button 
          className="back-button"
          onClick={handleBackToLessons}
          aria-label="Torna alle lezioni"
        >
          ← العودة للدروس
        </button>
        
        <h1 className="lesson-title">
          🇮🇹 من أين أتي؟ 🇸🇦
          <span className="italian-subtitle">Da dove vengo</span>
        </h1>
        
        <div className="progress-container">
          <div className="progress-bar">
            <div 
              className="progress-fill" 
              style={{ width: `${progress}%` }}
            />
          </div>
          <span className="progress-text">
            {progressText}
          </span>
        </div>
      </header>

      {/* Contenuto principale */}
      <main className="app-main">
        <BaseFlashcard 
          word={currentWord}
          isFlipped={isFlipped}
          onFlip={handleFlip}
          onAudioPlay={handleAudioPlay}
        />

        {/* Controlli di navigazione */}
        <div className="navigation">
          <button 
            className="nav-button prev"
            onClick={handlePrevious}
            disabled={!hasCards}
            aria-label="Carta precedente"
          >
            ← السابق
          </button>
          
          <button 
            className="flip-button"
            onClick={handleFlip}
            disabled={!hasCards}
            aria-label={isFlipped ? 'Mostra arabo' : 'Mostra italiano'}
          >
            {isFlipped ? 'أظهر العربية' : 'أظهر الإيطالية'}
          </button>
          
          <button 
            className="nav-button next"
            onClick={handleNext}
            disabled={!hasCards}
            aria-label="Carta successiva"
          >
            التالي →
          </button>
        </div>

        {/* Indicatore audio in riproduzione */}
        {isPlaying && (
          <div className="audio-playing-indicator">
            🔊 جاري تشغيل الصوت...
          </div>
        )}
      </main>

      {/* Stili per i nuovi elementi */}
      <style jsx>{`
        .back-button {
          position: fixed;
          top: 15px;
          left: 15px;
          background: #FF4444;
          color: white;
          border: 2px solid white;
          padding: 8px 16px;
          border-radius: 20px;
          font-family: 'Cairo', sans-serif;
          font-weight: 600;
          font-size: 0.9rem;
          cursor: pointer;
          transition: all 0.3s ease;
          z-index: 1000;
          box-shadow: 0 3px 10px rgba(0,0,0,0.3);
        }

        .back-button:hover {
          background: #FF6666;
          transform: translateY(-1px);
          box-shadow: 0 4px 15px rgba(0,0,0,0.4);
        }

        .lesson-title {
          color: white;
          font-size: 2.5rem;
          margin-bottom: 20px;
          text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
          font-family: 'Cairo', sans-serif;
          display: flex;
          flex-direction: column;
          align-items: center;
          gap: 5px;
        }

        .italian-subtitle {
          font-size: 1rem;
          font-weight: 400;
          color: rgba(255, 255, 255, 0.8);
          font-family: 'Inter', sans-serif;
          font-style: italic;
        }

        .audio-playing-indicator {
          text-align: center;
          margin-top: 20px;
          color: white;
          font-family: 'Cairo', sans-serif;
          font-size: 1.1rem;
          padding: 10px;
          background: rgba(255, 255, 255, 0.1);
          border-radius: 15px;
          backdrop-filter: blur(10px);
        }

        @media (max-width: 600px) {
          .back-button {
            top: 12px;
            left: 12px;
            padding: 6px 14px;
            font-size: 0.8rem;
          }

          .lesson-title {
            font-size: 2rem;
          }

          .italian-subtitle {
            font-size: 0.9rem;
          }
        }
      `}</style>
    </div>
  );
};

export default App;