import 'package:flutter/material.dart';

import '../../widgets/game_card.dart';

import '../../games/impostor/screens/impostor_screen.dart';
import '../../games/would_you_rather/screens/would_you_rather_screen.dart';
import '../../games/truth_or_dare/screens/truth_or_dare_screen.dart';
import '../../games/wrong_answer_only/screens/wrong_answer_only_screen.dart';
import '../../games/who_am_i/screens/who_am_i_screen.dart';
import '../../games/perfect_circle/screens/perfect_circle_screen.dart';
import '../../games/chess/screens/chess_screen.dart';
import '../../games/never_have_i_ever/screens/never_have_i_ever_screen.dart';
import '../../games/charades/screens/charades_screen.dart';
import '../../games/mafia/screens/mafia_screen.dart';

import '../settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BLUFFᴮᴰ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(
              Icons.settings_rounded,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 5 / 7,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GameCard(
                title: 'IMPOSTOR',
                description:
                    'Find the one who does not know the word.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ImpostorScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 1) {
              return GameCard(
                title: 'WOULD YOU RATHER',
                description:
                    'Choose between two difficult options.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const WouldYouRatherScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 2) {
              return GameCard(
                title: 'TRUTH OR DARE',
                description:
                    'Answer honestly or take the dare.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const TruthOrDareScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 3) {
              return GameCard(
                title: 'WRONG ANSWER ONLY',
                description:
                    'Give the funniest wrong answer.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const WrongAnswerOnlyScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 4) {
              return GameCard(
                title: 'WHO AM I?',
                description:
                    'Guess the person or character.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const WhoAmIScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 5) {
              return GameCard(
                title: 'PERFECT CIRCLE',
                description:
                    'Draw the closest circle you can.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const PerfectCircleScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 6) {
              return GameCard(
                title: 'CHESS',
                description:
                    'Play chess with your friends.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ChessScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 7) {
              return GameCard(
                title: 'NEVER HAVE I EVER',
                description:
                    'Reveal who has done it.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const NeverHaveIEverScreen(),
                    ),
                  );
                },
              );
            }

            if (index == 8) {
              return GameCard(
                title: 'CHARADES',
                description:
                    'Act it out without speaking.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const CharadesScreen(),
                    ),
                  );
                },
              );
            }

            return GameCard(
              title: 'MAFIA',
              description:
                  'Find the mafia before it is too late.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const MafiaScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}