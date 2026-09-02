import 'package:flutter/material.dart';

import '../logic/game_logic.dart';

class CharadesGameScreen extends StatefulWidget {
  const CharadesGameScreen({super.key});

  @override
  State<CharadesGameScreen> createState() =>
      _CharadesGameScreenState();
}

class _CharadesGameScreenState
    extends State<CharadesGameScreen> {
  late final CharadesGameLogic gameLogic;

  late String currentWord;

  int score = 0;
  int round = 1;

  @override
  void initState() {
    super.initState();

    gameLogic = CharadesGameLogic();
    currentWord = gameLogic.getNextWord();
  }

  void gotIt() {
    setState(() {
      score++;
      round++;
      currentWord = gameLogic.getNextWord();
    });
  }

  void skip() {
    setState(() {
      round++;
      currentWord = gameLogic.getNextWord();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Charades',
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
              const SizedBox(height: 15),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ROUND $round',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),

                  Text(
                    'SCORE $score',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ACT THIS OUT',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Text(
                            currentWord,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Text(
                            '🤫 Don\'t say the word!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color:
                                  Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: OutlinedButton(
                        onPressed: skip,
                        child: const Text(
                          'SKIP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: gotIt,
                        child: const Text(
                          'GOT IT!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}