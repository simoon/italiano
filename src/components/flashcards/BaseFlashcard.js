import React from 'react';

/**
 * Componente Flashcard di base
 * @param {Object} word - Oggetto contenente i dati della parola/frase
 * @param {boolean} isFlipped - Stato se la carta è girata o meno
 * @param {Function} onFlip - Callback per girare la carta
 * @param {Function} onAudioPlay - Callback per riprodurre l'audio
 */
const BaseFlashcard = ({ word, isFlipped, onFlip, onAudioPlay }) => {
  const handleCardClick = () => {
    onFlip();
  };

  const handleAudioClick = (e) => {
    e.stopPropagation(); // Previene il flip quando si clicca l'audio
    onAudioPlay(word.audio);
  };

  return (
    <div className="flashcard-container" onClick={handleCardClick}>
      <div className={`flashcard ${isFlipped ? 'flipped' : ''}`}>
        {/* Fronte della carta */}
        <div className="flashcard-front">
          <div className="image-container">
            <span className="emoji-image" role="img" aria-label={word.italian}>
              {word.image}
            </span>
          </div>
          <div className="arabic-text" dir="rtl">
            {word.arabic}
          </div>
          {word.category && (
            <div className="card-category">
              {word.category}
            </div>
          )}
        </div>
        
        {/* Retro della carta */}
        <div className="flashcard-back">
          <div className="italian-word">
            {word.italian}
          </div>
          <button 
            className="audio-button"
            onClick={handleAudioClick}
            aria-label={`Ascolta la pronuncia di: ${word.italian}`}
          >
            🔊 استمع
          </button>
          <div className="flip-hint">
            انقر للعودة
          </div>
        </div>
      </div>
    </div>
  );
};

export default BaseFlashcard;