import 'package:flutter/material.dart';
import '../logic/game_logic.dart';

class TruthOrDareGameScreen extends StatefulWidget {
  final List<String> selectedCategories;

  const TruthOrDareGameScreen({
    super.key,
    required this.selectedCategories,
  });

  @override
  State<TruthOrDareGameScreen> createState() =>
      _TruthOrDareGameScreenState();
}

class _TruthOrDareGameScreenState
    extends State<TruthOrDareGameScreen> {
  late TruthOrDareGameLogic game;

  @override
  void initState() {
    super.initState();

    game = TruthOrDareGameLogic(
      selectedCategories: widget.selectedCategories,
    );
  }

  void nextQuestion() {
    if (!game.hasMoreQuestions) {
      Navigator.pop(context);
      return;
    }

    game.nextQuestion();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = game.currentQuestion;

    if (question == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Truth or Dare'),
        ),
        body: const Center(
          child: Text('No questions available.'),
        ),
      );
    }

    final isTruth = question.type == 'Truth';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Truth or Dare',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                question.category,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                isTruth ? 'TRUTH' : 'DARE',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    question.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: nextQuestion,
                  child: const Text(
                    'DONE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: nextQuestion,
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}