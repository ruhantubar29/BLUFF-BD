import 'package:flutter/material.dart';

import '../logic/game_logic.dart';

class NeverHaveIEverGameScreen extends StatefulWidget {
  const NeverHaveIEverGameScreen({super.key});

  @override
  State<NeverHaveIEverGameScreen> createState() =>
      _NeverHaveIEverGameScreenState();
}

class _NeverHaveIEverGameScreenState
    extends State<NeverHaveIEverGameScreen> {
  late final NeverHaveIEverGameLogic gameLogic;

  late String currentStatement;

  @override
  void initState() {
    super.initState();

    gameLogic = NeverHaveIEverGameLogic();
    currentStatement = gameLogic.getNextStatement();
  }

  void nextStatement() {
    setState(() {
      currentStatement = gameLogic.getNextStatement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Never Have I Ever',
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
              const SizedBox(height: 20),

              Text(
                'NEVER HAVE I EVER...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          currentStatement,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                '${gameLogic.remainingCount} statements remaining',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: nextStatement,
                  child: const Text(
                    'NEXT',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}