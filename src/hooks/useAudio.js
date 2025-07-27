import { useState, useCallback, useRef } from 'react';

/**
 * Hook personalizzato per la gestione dell'audio con debug
 */
const useAudio = () => {
  const [isPlaying, setIsPlaying] = useState(false);
  const [error, setError] = useState(null);
  const audioRef = useRef(null);

  /**
   * Riproduce un file audio o usa la sintesi vocale come fallback
   */
  const playAudio = useCallback(async (audioPath, text, language = 'it-IT') => {
    console.log('🔊 DEBUG: Tentativo riproduzione audio');
    console.log('📁 Percorso file:', audioPath);
    console.log('📝 Testo fallback:', text);
    
    setError(null);
    
    // Ferma audio precedente se in riproduzione
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current = null;
    }

    try {
      if (audioPath) {
        console.log('🎵 Tentativo caricamento file MP3...');
        setIsPlaying(true);
        audioRef.current = new Audio(audioPath);
        
        audioRef.current.addEventListener('ended', () => {
          console.log('✅ Audio terminato');
          setIsPlaying(false);
        });

        audioRef.current.addEventListener('error', (e) => {
          console.error('❌ ERRORE FILE AUDIO:', e);
          console.error('❌ Dettagli errore:', {
            code: e.target?.error?.code,
            message: e.target?.error?.message,
            src: e.target?.src
          });
          console.log('🔄 Passaggio a sintesi vocale...');
          setIsPlaying(false);
          playSpeechSynthesis(text, language);
        });

        audioRef.current.addEventListener('loadstart', () => {
          console.log('📡 Inizio caricamento file audio');
        });

        audioRef.current.addEventListener('canplay', () => {
          console.log('✅ File audio pronto per riproduzione');
        });

        console.log('▶️ Tentativo play...');
        await audioRef.current.play();
        console.log('✅ Audio avviato con successo');
        
      } else {
        console.log('⚠️ Nessun percorso audio fornito, uso sintesi vocale');
        playSpeechSynthesis(text, language);
      }
    } catch (error) {
      console.error('💥 ERRORE GENERALE:', error);
      setError('Errore nella riproduzione audio');
      setIsPlaying(false);
      console.log('🔄 Fallback a sintesi vocale...');
      playSpeechSynthesis(text, language);
    }
  }, []);

  /**
   * Usa la Web Speech API per la sintesi vocale
   */
  const playSpeechSynthesis = useCallback((text, language = 'it-IT') => {
    console.log('🤖 Uso sintesi vocale per:', text);
    
    if ('speechSynthesis' in window && text) {
      try {
        setIsPlaying(true);
        
        // Cancella eventuali sintesi in corso
        speechSynthesis.cancel();
        
        const utterance = new SpeechSynthesisUtterance(text);
        utterance.lang = language;
        utterance.rate = 0.8;
        utterance.pitch = 1;
        utterance.volume = 1;
        
        utterance.onend = () => {
          console.log('✅ Sintesi vocale terminata');
          setIsPlaying(false);
        };
        
        utterance.onerror = (event) => {
          console.error('❌ Errore sintesi vocale:', event.error);
          setError('Errore nella sintesi vocale');
          setIsPlaying(false);
        };
        
        speechSynthesis.speak(utterance);
        console.log('🗣️ Sintesi vocale avviata');
        
      } catch (error) {
        console.error('💥 Errore nella sintesi vocale:', error);
        setError('Sintesi vocale non disponibile');
        setIsPlaying(false);
        
        // Ultimo fallback: alert con il testo
        alert(`Pronuncia: ${text}`);
      }
    } else {
      console.log('⚠️ Sintesi vocale non disponibile nel browser');
      alert(`Pronuncia: ${text}`);
    }
  }, []);

  /**
   * Ferma la riproduzione audio corrente
   */
  const stopAudio = useCallback(() => {
    console.log('⏹️ Interruzione audio');
    
    if (audioRef.current) {
      audioRef.current.pause();
      audioRef.current = null;
    }
    
    if ('speechSynthesis' in window) {
      speechSynthesis.cancel();
    }
    
    setIsPlaying(false);
  }, []);

  /**
   * Controlla se l'audio è supportato dal browser
   */
  const isAudioSupported = useCallback(() => {
    const supported = !!(window.Audio || window.speechSynthesis);
    console.log('🔊 Supporto audio:', supported);
    return supported;
  }, []);

  // Test per verificare se i file sono accessibili
  const testAudioFile = useCallback((audioPath) => {
    console.log('🧪 Test accessibilità file:', audioPath);
    
    fetch(audioPath, { method: 'HEAD' })
      .then(response => {
        if (response.ok) {
          console.log('✅ File accessibile:', audioPath);
        } else {
          console.error('❌ File non accessibile:', audioPath, 'Status:', response.status);
        }
      })
      .catch(error => {
        console.error('❌ Errore nel test file:', audioPath, error);
      });
  }, []);

  return {
    playAudio,
    stopAudio,
    isPlaying,
    error,
    isAudioSupported: isAudioSupported(),
    testAudioFile // Funzione di test aggiuntiva
  };
};

export default useAudio;