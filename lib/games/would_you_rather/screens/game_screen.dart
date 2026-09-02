import 'package:flutter/material.dart';
import '../logic/game_logic.dart';

class WouldYouRatherGameScreen extends StatefulWidget {
  final List<String> selectedCategories;

  const WouldYouRatherGameScreen({
    super.key,
    required this.selectedCategories,
  });

  @override
  State<WouldYouRatherGameScreen> createState() =>
      _WouldYouRatherGameScreenState();
}

class _WouldYouRatherGameScreenState
    extends State<WouldYouRatherGameScreen> {
  late WouldYouRatherGameLogic game;

  bool hasAnswered = false;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();

    game = WouldYouRatherGameLogic(
      selectedCategories: widget.selectedCategories,
    );
  }

  void selectAnswer(String answer) {
    if (hasAnswered) return;

    setState(() {
      hasAnswered = true;
      selectedAnswer = answer;
    });
  }

  void nextQuestion() {
    if (!game.hasMoreQuestions) {
      Navigator.pop(context);
      return;
    }

    game.nextQuestion();

    setState(() {
      hasAnswered = false;
      selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = game.currentQuestion;

    if (question == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Would You Rather'),
        ),
        body: const Center(
          child: Text('No questions available.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Would You Rather',
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  letterSpacing: 1.5,
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

              AnswerButton(
                text: question.optionA,
                isSelected: selectedAnswer == question.optionA,
                hasAnswered: hasAnswered,
                onTap: () => selectAnswer(question.optionA),
              ),

              const SizedBox(height: 14),

              const Text(
                'OR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 14),

              AnswerButton(
                text: question.optionB,
                isSelected: selectedAnswer == question.optionB,
                hasAnswered: hasAnswered,
                onTap: () => selectAnswer(question.optionB),
              ),

              const SizedBox(height: 20),

              AnimatedOpacity(
                opacity: hasAnswered ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: hasAnswered ? nextQuestion : null,
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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

class AnswerButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool hasAnswered;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.hasAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        onPressed: hasAnswered ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? colorScheme.primaryContainer : null,
          foregroundColor:
              isSelected ? colorScheme.onPrimaryContainer : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}