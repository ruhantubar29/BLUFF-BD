import 'package:flutter/material.dart';
import '../../../widgets/bluff_button.dart';
import '../../../widgets/bluff_card.dart';
import 'category_screen.dart';
import 'game_screen.dart';

class WrongAnswerOnlyScreen extends StatefulWidget {
  const WrongAnswerOnlyScreen({super.key});

  @override
  State<WrongAnswerOnlyScreen> createState() =>
      _WrongAnswerOnlyScreenState();
}

class _WrongAnswerOnlyScreenState
    extends State<WrongAnswerOnlyScreen> {
  List<String> selectedCategories = ['Classic'];

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WrongAnswerOnlyGameScreen(
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
          'Wrong Answer Only',
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

            const Text(
              'CATEGORY',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            BluffCard(
              onTap: openCategoryScreen,
              child: Row(
                children: [
                  const Icon(
                    Icons.category_rounded,
                    size: 30,
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Choose Categories',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          selectedCategories.join(', '),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
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