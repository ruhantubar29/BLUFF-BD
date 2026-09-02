import 'package:flutter/material.dart';

import 'game_screen.dart';

class NeverHaveIEverScreen extends StatelessWidget {
  const NeverHaveIEverScreen({super.key});

  void startGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NeverHaveIEverGameScreen(),
      ),
    );
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
              const Spacer(),

              const Text(
                '🙈',
                style: TextStyle(
                  fontSize: 90,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Never Have I Ever',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Find out what your friends have done!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => startGame(context),
                  child: const Text(
                    'GAME',
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