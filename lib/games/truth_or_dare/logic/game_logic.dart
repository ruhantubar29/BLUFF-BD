import '../data/bn/questions.dart';

class TruthOrDareGameLogic {
  final List<String> selectedCategories;

  late List<TruthOrDareQuestion> _questions;

  int _currentIndex = 0;

  TruthOrDareGameLogic({
    required this.selectedCategories,
  }) {
    _prepareQuestions();
  }

  void _prepareQuestions() {
    _questions = truthOrDareQuestions
        .where(
          (question) =>
              selectedCategories.contains(question.category),
        )
        .toList();

    _questions.shuffle();
  }

  TruthOrDareQuestion? get currentQuestion {
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