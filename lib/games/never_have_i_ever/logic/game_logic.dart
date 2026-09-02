import 'dart:math';

import '../data/bn/statements.dart';

class NeverHaveIEverGameLogic {
  final List<String> _remainingStatements = [];

  final Random _random = Random();

  NeverHaveIEverGameLogic() {
    _reset();
  }

  void _reset() {
    _remainingStatements
      ..clear()
      ..addAll(neverHaveIEverStatements);
  }

  String getNextStatement() {
    if (_remainingStatements.isEmpty) {
      _reset();
    }

    final index = _random.nextInt(
      _remainingStatements.length,
    );

    return _remainingStatements.removeAt(index);
  }

  int get remainingCount =>
      _remainingStatements.length;

  int get totalCount =>
      neverHaveIEverStatements.length;
}