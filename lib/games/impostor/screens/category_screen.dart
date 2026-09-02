import 'package:flutter/material.dart';

import '../../../core/language/app_language.dart';
import '../logic/word_deck.dart';

/// Emoji shown before each category name.
const Map<String, String> _categoryEmojis = {
  'Animals': '🐾',
  'Food': '🍔',
  'Superheroes': '🦸',
  'Sports': '⚽',
  'Countries': '🌍',
  'Jobs': '💼',
  'Fruits': '🍎',
  'Cartoons': '📺',
  'Brands': '🏷️',
  'Anime': '🍥',
};

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.language,
    required this.selectedCategories,
  });

  final AppLanguage language;
  final List<String> selectedCategories;

  @override
  State<CategoryScreen> createState() =>
      _CategoryScreenState();
}

class _CategoryScreenState
    extends State<CategoryScreen> {
  late List<String> _categories;
  late Set<String> _selectedCategories;

  @override
  void initState() {
    super.initState();

    _categories =
        ImpostorWordDeck.instance.categories(
      widget.language,
    );

    _selectedCategories =
        widget.selectedCategories.toSet();

    // At least one category must always remain selected.
    if (_selectedCategories.isEmpty &&
        _categories.isNotEmpty) {
      _selectedCategories.add(
        _categories.first,
      );
    }
  }

  // --------------------------------------------------
  // TOGGLE CATEGORY
  // --------------------------------------------------

  void _toggleCategory(
    String category,
  ) {
    if (_selectedCategories.contains(category) &&
        _selectedCategories.length == 1) {
      return;
    }

    setState(() {
      if (_selectedCategories.contains(category)) {
        _selectedCategories.remove(category);
      } else {
        _selectedCategories.add(category);
      }
    });
  }

  // --------------------------------------------------
  // DONE
  // --------------------------------------------------

  void _done() {
    Navigator.pop(
      context,
      _selectedCategories.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),
          child: Column(
            children: [
              // ==========================================================
              // HEADER
              // ==========================================================

              Row(
                children: [
                  IconButton(
                    splashRadius: 24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ==========================================================
              // CATEGORY LIST
              // ==========================================================

              Expanded(
                child: ListView.builder(
                  itemCount: _categories.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final category =
                        _categories[index];

                    final selected =
                        _selectedCategories
                            .contains(category);

                    final emoji =
                        _categoryEmojis[
                                category] ??
                            '🔸';

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: _CategoryCard(
                        category: category,
                        emoji: emoji,
                        selected: selected,
                        onTap: () {
                          _toggleCategory(
                            category,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

              // ==========================================================
              // DONE BUTTON
              // ==========================================================

              _GlassCard(
                radius: 22,
                onTap: _done,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ],
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

// ======================================================================
// CATEGORY CARD
// ======================================================================

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  final String category;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      radius: 22,
      onTap: onTap,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),

        // --------------------------------------------------
        // CHECK ICON
        // --------------------------------------------------

        leading: AnimatedSwitcher(
          duration:
              const Duration(
            milliseconds: 220,
          ),
          child: selected
              ? const Icon(
                  Icons.check_circle_rounded,
                  key: ValueKey(true),
                  color: Colors.white,
                  size: 30,
                )
              : const Icon(
                  Icons
                      .radio_button_unchecked_rounded,
                  key: ValueKey(false),
                  color: Colors.white54,
                  size: 30,
                ),
        ),

        // --------------------------------------------------
        // CATEGORY NAME
        // --------------------------------------------------

        title: Text(
          '$emoji  $category',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ======================================================================
// GLASS CARD
// ======================================================================

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.radius,
    required this.onTap,
    required this.child,
  });

  final double radius;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(radius),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(radius),
            color: Colors.white.withValues(
              alpha: 0.08,
            ),
            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.12,
              ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}