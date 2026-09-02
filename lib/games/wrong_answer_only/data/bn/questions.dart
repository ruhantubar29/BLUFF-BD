class WrongAnswerQuestion {
  final String category;
  final String question;
  final String correctAnswer;

  const WrongAnswerQuestion({
    required this.category,
    required this.question,
    required this.correctAnswer,
  });
}

const List<WrongAnswerQuestion> wrongAnswerQuestions = [
  WrongAnswerQuestion(
    category: 'Classic',
    question: 'বাংলাদেশের রাজধানীর নাম কী?',
    correctAnswer: 'ঢাকা',
  ),
  WrongAnswerQuestion(
    category: 'Classic',
    question: 'সূর্য কোন দিক থেকে ওঠে?',
    correctAnswer: 'পূর্ব',
  ),
  WrongAnswerQuestion(
    category: 'Classic',
    question: 'এক সপ্তাহে কয় দিন?',
    correctAnswer: '৭ দিন',
  ),
  WrongAnswerQuestion(
    category: 'Funny',
    question: 'বিড়াল কী বলে?',
    correctAnswer: 'ম্যাঁও',
  ),
  WrongAnswerQuestion(
    category: 'Funny',
    question: 'মাছ কোথায় থাকে?',
    correctAnswer: 'পানিতে',
  ),
  WrongAnswerQuestion(
    category: 'Funny',
    question: 'আকাশের রং কী?',
    correctAnswer: 'নীল',
  ),
  WrongAnswerQuestion(
    category: 'Party',
    question: 'পার্টিতে সাধারণত মানুষ কী করে?',
    correctAnswer: 'আনন্দ করে',
  ),
  WrongAnswerQuestion(
    category: 'Party',
    question: 'জন্মদিনে সাধারণত কী কাটা হয়?',
    correctAnswer: 'কেক',
  ),
  WrongAnswerQuestion(
    category: 'Random',
    question: 'মানুষ কোন অঙ্গ দিয়ে দেখে?',
    correctAnswer: 'চোখ',
  ),
  WrongAnswerQuestion(
    category: 'Random',
    question: 'পানি জমে কী হয়?',
    correctAnswer: 'বরফ',
  ),
];