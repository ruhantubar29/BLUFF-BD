import 'dart:math';

import '../../../core/language/app_language.dart';
import '../data/bn/word_bank.dart' as bangla;
import '../data/en/word_bank.dart' as english;

class ImpostorWord {
  final String word;
  final String hint;

  const ImpostorWord({
    required this.word,
    required this.hint,
  });
}

class ImpostorWordDeck {
  ImpostorWordDeck._();

  static final ImpostorWordDeck instance =
      ImpostorWordDeck._();

  final Random _random = Random();

  final Map<String, List<int>> _queues = {};

  List<ImpostorWord> _entriesFor(
    AppLanguage language,
    String category,
  ) {
    if (language == AppLanguage.bangla) {
      final entries =
          bangla.WordBank.entriesFor(category);

      return entries
          .map(
            (entry) => ImpostorWord(
              word: entry.word,
              hint: entry.hints.isEmpty
                  ? ''
                  : entry.hints[
                      _random.nextInt(
                        entry.hints.length,
                      )
                    ],
            ),
          )
          .toList();
    }

    final entries =
        english.WordBank.entriesFor(category);

    return entries
        .map(
          (entry) => ImpostorWord(
            word: entry.word,
            hint: entry.hints.isEmpty
                ? ''
                : entry.hints[
                    _random.nextInt(
                      entry.hints.length,
                    )
                  ],
          ),
        )
        .toList();
  }

  ImpostorWord next({
    required AppLanguage language,
    required String category,
  }) {
    final entries = _entriesFor(
      language,
      category,
    );

    if (entries.isEmpty) {
      throw Exception(
        'No words available for category: $category',
      );
    }

    final queueKey =
        '${language.code}:$category';

    var queue = _queues[queueKey];

    if (queue == null || queue.isEmpty) {
      queue = List<int>.generate(
        entries.length,
        (index) => index,
      )..shuffle(_random);

      _queues[queueKey] = queue;
    }

    final index = queue.removeAt(0);

    return entries[index];
  }

  List<String> categories(
    AppLanguage language,
  ) {
    if (language == AppLanguage.bangla) {
      return bangla.WordBank.bank.keys.toList();
    }

    return english.WordBank.bank.keys.toList();
  }

  void reset() {
    _queues.clear();
  }
}