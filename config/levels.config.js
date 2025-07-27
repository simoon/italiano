/**
 * Configurazione dei livelli di apprendimento
 * Definisce i livelli disponibili e le loro caratteristiche
 */

export const LEVELS = {
  BEGINNER: {
    id: 'beginner',
    name: 'Principiante',
    arabicName: 'مبتدئ',
    order: 1,
    color: '#4CAF50',
    icon: '🌱',
    description: 'Livello base per iniziare con l\'italiano',
    arabicDescription: 'المستوى الأساسي لبدء تعلم الإيطالية',
    topics: [
      'identity',
      'family', 
      'colors',
      'numbers',
      'basic-verbs',
      'greetings',
      'daily-objects'
    ],
    maxCards: 10,
    repetitionFrequency: 'daily',
    estimatedTime: '15-20 min',
    requirements: null, // Nessun prerequisito
    nextLevel: 'intermediate'
  },
  
  INTERMEDIATE: {
    id: 'intermediate',
    name: 'Intermedio',
    arabicName: 'متوسط',
    order: 2,
    color: '#FF9800',
    icon: '📚',
    description: 'Livello intermedio per approfondire la grammatica',
    arabicDescription: 'المستوى المتوسط لتعميق القواعد النحوية',
    topics: [
      'past-tense',
      'future-tense',
      'complex-sentences',
      'prepositions',
      'modal-verbs',
      'time-expressions',
      'food-and-restaurants'
    ],
    maxCards: 15,
    repetitionFrequency: 'every-2-days',
    estimatedTime: '20-30 min',
    requirements: ['beginner'], // Deve completare il livello principiante
    nextLevel: 'advanced'
  },
  
  ADVANCED: {
    id: 'advanced',
    name: 'Avanzato',
    arabicName: 'متقدم',
    order: 3,
    color: '#F44336',
    icon: '🎓',
    description: 'Livello avanzato per padroneggiare l\'italiano',
    arabicDescription: 'المستوى المتقدم لإتقان اللغة الإيطالية',
    topics: [
      'subjunctive',
      'conditional',
      'business-italian',
      'literature',
      'advanced-grammar',
      'idioms',
      'formal-communication'
    ],
    maxCards: 20,
    repetitionFrequency: 'weekly',
    estimatedTime: '30-45 min',
    requirements: ['beginner', 'intermediate'], // Deve completare i livelli precedenti
    nextLevel: null // Livello finale
  }
};

/**