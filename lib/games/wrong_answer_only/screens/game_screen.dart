import 'package:flutter/material.dart';
import '../logic/game_logic.dart';

class WrongAnswerOnlyGameScreen extends StatefulWidget {
  final List<String> selectedCategories;

  const WrongAnswerOnlyGameScreen({
    super.key,
    required this.selectedCategories,
  });

  @override
  State<WrongAnswerOnlyGameScreen> createState() =>
      _WrongAnswerOnlyGameScreenState();
}

class _WrongAnswerOnlyGameScreenState
    extends State<WrongAnswerOnlyGameScreen> {
  late WrongAnswerOnlyGameLogic game;

  final TextEditingController controller =
      TextEditingController();

  bool submitted = false;

  @override
  void initState() {
    super.initState();

    game = WrongAnswerOnlyGameLogic(
      selectedCategories: widget.selectedCategories,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void submitAnswer() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      submitted = true;
    });
  }

  void nextQuestion() {
    game.nextQuestion();

    controller.clear();

    setState(() {
      submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = game.currentQuestion;

    if (question == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wrong Answer Only'),
        ),
        body: const Center(
          child: Text('Game Over!'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wrong Answer Only',
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

              const SizedBox(height: 30),

              Expanded(
                child: Center(
                  child: Text(
                    question.question,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              TextField(
                controller: controller,
                enabled: !submitted,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Give a WRONG answer...',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => submitAnswer(),
              ),

              const SizedBox(height: 15),

              if (!submitted)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: submitAnswer,
                    child: const Text('SUBMIT'),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    child: const Text('NEXT'),
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}