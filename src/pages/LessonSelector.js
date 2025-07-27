import React from 'react';
import { identityVocabulary } from '../data/topics/identity';

/**
 * Pagina di selezione delle lezioni
 */
const LessonSelector = ({ onLessonSelect }) => {
  // Configurazione delle lezioni disponibili
  const availableLessons = [
    {
      id: 'identity',
      title: 'من أين أتي؟',
      subtitle: 'Da dove vengo',
      description: 'تعلم كيفية تقديم نفسك ووصف هويتك',
      icon: '👤',
      color: '#4CAF50',
      cardsCount: identityVocabulary.length, // ← DINAMICO!
      level: 'مبتدئ',
      estimatedTime: '15 دقيقة'
    },
    {
      id: 'family',
      title: 'عائلتي',
      subtitle: 'La mia famiglia',
      description: 'تعلم أسماء أفراد العائلة والعلاقات',
      icon: '👨‍👩‍👧‍👦',
      color: '#2196F3',
      cardsCount: 12,
      level: 'مبتدئ',
      estimatedTime: '20 دقيقة',
      disabled: true // Per ora disabilitato
    },
    {
      id: 'colors',
      title: 'الألوان',
      subtitle: 'I colori',
      description: 'تعلم أسماء الألوان باللغة الإيطالية',
      icon: '🌈',
      color: '#FF9800',
      cardsCount: 10,
      level: 'مبتدئ',
      estimatedTime: '15 دقيقة',
      disabled: true // Per ora disabilitato
    }
  ];

  const handleLessonClick = (lessonId) => {
    if (onLessonSelect) {
      onLessonSelect(lessonId);
    }
  };

  return (
    <div className="lesson-selector">
      {/* Header */}
      <header className="lesson-header">
        <h1 className="main-title">راجع الدروس</h1>
        <p className="subtitle">اختر درساً لتبدأ المراجعة</p>
      </header>

      {/* Griglia delle lezioni */}
      <main className="lessons-grid">
        {availableLessons.map((lesson) => (
          <div
            key={lesson.id}
            className={`lesson-card ${lesson.disabled ? 'disabled' : ''}`}
            onClick={() => !lesson.disabled && handleLessonClick(lesson.id)}
            style={{
              borderLeft: `4px solid ${lesson.color}`,
              cursor: lesson.disabled ? 'not-allowed' : 'pointer'
            }}
          >
            {/* Icona e titolo */}
            <div className="lesson-header-content">
              <span className="lesson-icon" role="img" aria-label={lesson.title}>
                {lesson.icon}
              </span>
              <div className="lesson-titles">
                <h3 className="lesson-title-arabic">{lesson.title}</h3>
                <p className="lesson-title-italian">{lesson.subtitle}</p>
              </div>
            </div>

            {/* Descrizione */}
            <p className="lesson-description">{lesson.description}</p>

            {/* Informazioni della lezione */}
            <div className="lesson-info">
              <div className="info-item">
                <span className="info-label">المستوى:</span>
                <span className="info-value">{lesson.level}</span>
              </div>
              <div className="info-item">
                <span className="info-label">البطاقات:</span>
                <span className="info-value">{lesson.cardsCount}</span>
              </div>
              <div className="info-item">
                <span className="info-label">الوقت:</span>
                <span className="info-value">{lesson.estimatedTime}</span>
              </div>
            </div>

            {/* Stato della lezione */}
            {lesson.disabled ? (
              <div className="lesson-status disabled">
                قريباً
              </div>
            ) : (
              <div className="lesson-status available">
                ابدأ الدرس ←
              </div>
            )}
          </div>
        ))}
      </main>

      {/* Footer informativo */}
      <footer className="lesson-footer">
        <p className="footer-text">
          💡 نصيحة: ابدأ بدرس "من أين أتي؟" لتعلم أساسيات التعريف بالنفس
        </p>
      </footer>

      <style jsx>{`
        .lesson-selector {
          font-family: 'Cairo', sans-serif;
          max-width: 900px;
          margin: 0 auto;
          padding: 20px;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          min-height: 100vh;
          direction: rtl;
        }

        .lesson-header {
          text-align: center;
          margin-bottom: 40px;
          padding: 30px 20px;
          background: rgba(255, 255, 255, 0.1);
          border-radius: 20px;
          backdrop-filter: blur(10px);
        }

        .main-title {
          color: white;
          font-size: 3rem;
          font-weight: 700;
          margin-bottom: 10px;
          text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .subtitle {
          color: rgba(255, 255, 255, 0.9);
          font-size: 1.3rem;
          font-weight: 400;
          margin: 0;
        }

        .lessons-grid {
          display: grid;
          grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
          gap: 25px;
          margin-bottom: 40px;
        }

        .lesson-card {
          background: white;
          border-radius: 20px;
          padding: 25px;
          box-shadow: 0 10px 30px rgba(0,0,0,0.2);
          transition: all 0.3s ease;
          position: relative;
          overflow: hidden;
        }

        .lesson-card:not(.disabled):hover {
          transform: translateY(-5px);
          box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }

        .lesson-card.disabled {
          opacity: 0.6;
          background: #f5f5f5;
        }

        .lesson-header-content {
          display: flex;
          align-items: center;
          gap: 15px;
          margin-bottom: 15px;
        }

        .lesson-icon {
          font-size: 3rem;
          display: block;
        }

        .lesson-titles {
          flex: 1;
        }

        .lesson-title-arabic {
          font-size: 1.5rem;
          font-weight: 700;
          color: #333;
          margin: 0 0 5px 0;
        }

        .lesson-title-italian {
          font-size: 1rem;
          color: #666;
          margin: 0;
          font-style: italic;
        }

        .lesson-description {
          color: #555;
          font-size: 1rem;
          line-height: 1.5;
          margin-bottom: 20px;
        }

        .lesson-info {
          display: grid;
          grid-template-columns: repeat(3, 1fr);
          gap: 15px;
          margin-bottom: 20px;
          padding: 15px;
          background: #f8f9fa;
          border-radius: 10px;
        }

        .info-item {
          text-align: center;
        }

        .info-label {
          display: block;
          font-size: 0.8rem;
          color: #666;
          margin-bottom: 5px;
        }

        .info-value {
          display: block;
          font-size: 1rem;
          font-weight: 600;
          color: #333;
        }

        .lesson-status {
          text-align: center;
          padding: 12px;
          border-radius: 10px;
          font-weight: 600;
          font-size: 1.1rem;
        }

        .lesson-status.available {
          background: #4CAF50;
          color: white;
        }

        .lesson-status.disabled {
          background: #ccc;
          color: #666;
        }

        .lesson-footer {
          text-align: center;
          padding: 20px;
          background: rgba(255, 255, 255, 0.1);
          border-radius: 15px;
          backdrop-filter: blur(10px);
        }

        .footer-text {
          color: white;
          font-size: 1.1rem;
          margin: 0;
          line-height: 1.5;
        }

        /* Responsive */
        @media (max-width: 768px) {
          .lesson-selector {
            padding: 15px;
          }

          .main-title {
            font-size: 2.5rem;
          }

          .subtitle {
            font-size: 1.1rem;
          }

          .lessons-grid {
            grid-template-columns: 1fr;
            gap: 20px;
          }

          .lesson-card {
            padding: 20px;
          }

          .lesson-info {
            grid-template-columns: 1fr;
            gap: 10px;
          }

          .lesson-icon {
            font-size: 2.5rem;
          }

          .lesson-title-arabic {
            font-size: 1.3rem;
          }
        }
      `}</style>
    </div>
  );
};

export default LessonSelector;