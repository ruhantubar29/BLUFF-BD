import 'dart:math';

import '../data/bn/words.dart';

class CharadesGameLogic {
  final List<String> _remainingWords = [];
  final Random _random = Random();

  CharadesGameLogic() {
    _reset();
  }

  void _reset() {
    _remainingWords
      ..clear()
      ..addAll(charadesWords);
  }

  String getNextWord() {
    if (_remainingWords.isEmpty) {
      _reset();
    }

    final index = _random.nextInt(
      _remainingWords.length,
    );

    return _remainingWords.removeAt(index);
  }

  int get remainingCount =>
      _remainingWords.length;

  int get totalCount =>
      charadesWords.length;
}