import '../data/bn/questions.dart';

class WrongAnswerOnlyGameLogic {
  final List<String> selectedCategories;

  late List<WrongAnswerQuestion> _questions;

  int _currentIndex = 0;

  WrongAnswerOnlyGameLogic({
    required this.selectedCategories,
  }) {
    _prepareQuestions();
  }

  void _prepareQuestions() {
    _questions = wrongAnswerQuestions
        .where(
          (question) =>
              selectedCategories.contains(question.category),
        )
        .toList();

    _questions.shuffle();
  }

  WrongAnswerQuestion? get currentQuestion {
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