import 'game_screen.dart';
import 'package:flutter/material.dart';
import '../../../widgets/bluff_button.dart';
import '../../../widgets/bluff_card.dart';
import 'category_screen.dart';

class WouldYouRatherScreen extends StatefulWidget {
  const WouldYouRatherScreen({super.key});

  @override
  State<WouldYouRatherScreen> createState() => _WouldYouRatherScreenState();
}

class _WouldYouRatherScreenState extends State<WouldYouRatherScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Would You Rather',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => WouldYouRatherGameScreen(
          selectedCategories: selectedCategories,
        ),
      ),
    );
  },
),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}