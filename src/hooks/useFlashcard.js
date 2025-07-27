import { useState, useEffect, useCallback } from 'react';

/**
 * Hook personalizzato per la gestione delle flashcard
 * Gestisce navigazione, progresso e stato delle carte
 */
const useFlashcard = (vocabularyData = []) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const [isFlipped, setIsFlipped] = useState(false);
  const [progress, setProgress] = useState(0);
  const [studyStats, setStudyStats] = useState({
    cardsReviewed: 0,
    correctAnswers: 0,
    startTime: Date.now()
  });

  // Carta corrente
  const currentWord = vocabularyData[currentIndex] || null;
  const totalCards = vocabularyData.length;
  const hasCards = totalCards > 0;

  // Calcola il progresso ogni volta che cambia l'indice
  useEffect(() => {
    if (hasCards) {
      setProgress(((currentIndex + 1) / totalCards) * 100);
    }
  }, [currentIndex, totalCards, hasCards]);

  /**
   * Gira la carta corrente
   */
  const handleFlip = useCallback(() => {
    setIsFlipped(prev => !prev);
  }, []);

  /**
   * Va alla carta successiva
   */
  const handleNext = useCallback(() => {
    if (hasCards) {
      setCurrentIndex(prev => (prev + 1) % totalCards);
      setIsFlipped(false);
      
      // Aggiorna statistiche
      setStudyStats(prev => ({
        ...prev,
        cardsReviewed: prev.cardsReviewed + 1
      }));
    }
  }, [hasCards, totalCards]);

  /**
   * Va alla carta precedente
   */
  const handlePrevious = useCallback(() => {
    if (hasCards) {
      setCurrentIndex(prev => (prev - 1 + totalCards) % totalCards);
      setIsFlipped(false);
    }
  }, [hasCards, totalCards]);

  /**
   * Va a una carta specifica
   */
  const goToCard = useCallback((index) => {
    if (hasCards && index >= 0 && index < totalCards) {
      setCurrentIndex(index);
      setIsFlipped(false);
    }
  }, [hasCards, totalCards]);

  /**
   * Rimescola le carte
   */
  const shuffleCards = useCallback(() => {
    if (hasCards) {
      // Reset alla prima carta dopo il rimescolamento
      setCurrentIndex(0);
      setIsFlipped(false);
    }
  }, [hasCards]);

  /**
   * Reset della sessione di studio
   */
  const resetSession = useCallback(() => {
    setCurrentIndex(0);
    setIsFlipped(false);
    setProgress(0);
    setStudyStats({
      cardsReviewed: 0,
      correctAnswers: 0,
      startTime: Date.now()
    });
  }, []);

  /**
   * Marca una risposta come corretta/sbagliata
   */
  const markAnswer = useCallback((isCorrect) => {
    setStudyStats(prev => ({
      ...prev,
      correctAnswers: isCorrect ? prev.correctAnswers + 1 : prev.correctAnswers
    }));
  }, []);

  /**
   * Calcola il tempo di studio trascorso
   */
  const getStudyTime = useCallback(() => {
    return Math.floor((Date.now() - studyStats.startTime) / 1000); // in secondi
  }, [studyStats.startTime]);

  /**
   * Controlla se è l'ultima carta
   */
  const isLastCard = currentIndex === totalCards - 1;

  /**
   * Controlla se è la prima carta
   */
  const isFirstCard = currentIndex === 0;

  /**
   * Calcola la percentuale di risposte corrette
   */
  const getAccuracy = useCallback(() => {
    if (studyStats.cardsReviewed === 0) return 0;
    return Math.round((studyStats.correctAnswers / studyStats.cardsReviewed) * 100);
  }, [studyStats.cardsReviewed, studyStats.correctAnswers]);

  return {
    // Stato corrente
    currentWord,
    currentIndex,
    isFlipped,
    progress,
    totalCards,
    hasCards,
    
    // Controlli di navigazione
    handleFlip,
    handleNext,
    handlePrevious,
    goToCard,
    shuffleCards,
    resetSession,
    
    // Statistiche e stato
    studyStats,
    markAnswer,
    getStudyTime,
    getAccuracy,
    isLastCard,
    isFirstCard,
    
    // Informazioni utili
    progressText: hasCards ? `${currentIndex + 1} / ${totalCards}` : '0 / 0',
    completionPercentage: Math.round(progress)
  };
};

export default useFlashcard;