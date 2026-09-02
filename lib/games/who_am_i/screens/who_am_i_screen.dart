import 'package:flutter/material.dart';

import '../../../widgets/bluff_button.dart';
import '../../../widgets/bluff_card.dart';
import 'player_screen.dart';
import 'category_screen.dart';
import 'game_screen.dart';

class WhoAmIScreen extends StatefulWidget {
  const WhoAmIScreen({super.key});

  @override
  State<WhoAmIScreen> createState() => _WhoAmIScreenState();
}

class _WhoAmIScreenState extends State<WhoAmIScreen> {
  List<String> players = [
    'Player 1',
    'Player 2',
  ];

  List<String> selectedCategories = [
    'Animals',
  ];

  Future<void> openPlayerScreen() async {
    final result = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(
          players: players,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        players = result;
      });
    }
  }

  Future<void> openCategoryScreen() async {
    final result = await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryScreen(
          selectedCategories: selectedCategories,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        selectedCategories = result;
      });
    }
  }

  void startGame() {
  if (players.length < 2) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('At least 2 players are required.'),
      ),
    );
    return;
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => WhoAmIGameScreen(
        players: players,
        selectedCategories: selectedCategories,
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Who Am I?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // PLAYERS
            BluffCard(
              onTap: openPlayerScreen,
              child: Row(
                children: [
                  const Icon(
                    Icons.people_rounded,
                    size: 30,
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Players',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          '${players.length} Players',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // CATEGORY
            BluffCard(
              onTap: openCategoryScreen,
              child: Row(
                children: [
                  const Icon(
                    Icons.category_rounded,
                    size: 30,
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          selectedCategories.join(', '),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ],
              ),
            ),

            const Spacer(),

            BluffButton(
              text: 'GAME',
              onPressed: startGame,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}