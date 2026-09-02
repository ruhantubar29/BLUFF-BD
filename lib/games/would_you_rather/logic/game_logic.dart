import '../data/bn/questions.dart';

class WouldYouRatherGameLogic {
  final List<String> selectedCategories;

  late List<WouldYouRatherQuestion> _questions;
  int _currentIndex = 0;

  WouldYouRatherGameLogic({
    required this.selectedCategories,
  }) {
    _prepareQuestions();
  }

  void _prepareQuestions() {
    _questions = wouldYouRatherQuestions
        .where(
          (question) =>
              selectedCategories.contains(question.category),
        )
        .toList();

    _questions.shuffle();
  }

  WouldYouRatherQuestion? get currentQuestion {
    if (_currentIndex >= _questions.length) {
      return null;
    }

    return _questions[_currentIndex];
  }

  bool get hasMoreQuestions {
    return _currentIndex < _questions.length;
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length) {
      _currentIndex++;
    }
  }
}