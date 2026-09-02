import 'package:flutter/material.dart';

import '../../../core/language/app_language.dart';
import '../../../core/language/language_settings.dart';
import '../logic/impostor_round_generator.dart';
import '../logic/word_deck.dart';
import '../models/impostor_player.dart';
import '../models/impostor_settings.dart';
import 'category_screen.dart';
import 'game_screen.dart';
import 'impostor_count_screen.dart';
import 'player_screen.dart';

class ImpostorScreen extends StatefulWidget {
  const ImpostorScreen({super.key});

  @override
  State<ImpostorScreen> createState() =>
      _ImpostorScreenState();
}

class _ImpostorScreenState
    extends State<ImpostorScreen> {
  late AppLanguage _language;

  bool _hintsEnabled = true;

  bool _randomImpostorCount = false;

  int _impostorCount = 1;

  List<ImpostorPlayer> _players = [
    ImpostorPlayer(name: 'Player 1'),
    ImpostorPlayer(name: 'Player 2'),
    ImpostorPlayer(name: 'Player 3'),
    ImpostorPlayer(name: 'Player 4'),
  ];

  late List<String> _categories;
  late Set<String> _selectedCategories;

  @override
  void initState() {
    super.initState();

    _language =
        LanguageSettings.instance.language;

    _categories =
        ImpostorWordDeck.instance.categories(
      _language,
    );

    _selectedCategories =
        _categories.toSet();
  }

  // --------------------------------------------------
  // MAXIMUM IMPOSTORS
  // --------------------------------------------------

  int _maximumImpostors(int players) {
    if (players >= 16) {
      return 6;
    }

    if (players >= 13) {
      return 5;
    }

    if (players >= 10) {
      return 4;
    }

    if (players >= 7) {
      return 3;
    }

    if (players >= 5) {
      return 2;
    }

    return 1;
  }

  // --------------------------------------------------
  // OPEN PLAYER SCREEN
  // --------------------------------------------------

  Future<void> _openPlayerScreen() async {
    final updatedPlayers =
        await Navigator.push<List<ImpostorPlayer>>(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(
          players: _players,
        ),
      ),
    );

    if (updatedPlayers == null) {
      return;
    }

    setState(() {
      _players = updatedPlayers;
    });

    _validateImpostorCount();
  }

  // --------------------------------------------------
  // VALIDATE IMPOSTOR COUNT
  // --------------------------------------------------

  void _validateImpostorCount() {
    final maximumImpostors =
        _maximumImpostors(_players.length);

    if (_impostorCount > maximumImpostors) {
      setState(() {
        _impostorCount =
            maximumImpostors;
      });
    }
  }

  // --------------------------------------------------
  // OPEN IMPOSTOR COUNT SCREEN
  // --------------------------------------------------

  Future<void> _openImpostorCountScreen() async {
    final selection =
        await Navigator.push<ImpostorCountSelection>(
      context,
      MaterialPageRoute(
        builder: (_) => ImpostorCountScreen(
          playerCount: _players.length,
          selectedCount: _impostorCount,
          randomEnabled:
              _randomImpostorCount,
        ),
      ),
    );

    if (selection == null) {
      return;
    }

    setState(() {
      _impostorCount =
          selection.count;

      _randomImpostorCount =
          selection.randomEnabled;
    });
  }

  // --------------------------------------------------
  // OPEN CATEGORY SCREEN
  // --------------------------------------------------

  Future<void> _openCategoryScreen() async {
    final selected =
        await Navigator.push<List<String>>(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryScreen(
          language: _language,
          selectedCategories:
              _selectedCategories.toList(),
        ),
      ),
    );

    if (selected == null) {
      return;
    }

    setState(() {
      _selectedCategories =
          selected.toSet();
    });
  }

  // --------------------------------------------------
  // START GAME
  // --------------------------------------------------

  void _startGame() {
    if (_players.length <
        ImpostorSettings.minPlayers) {
      return;
    }

    if (_players.length >
        ImpostorSettings.maxPlayers) {
      return;
    }

    if (_selectedCategories.isEmpty) {
      return;
    }

    final maximumImpostors =
        _maximumImpostors(_players.length);

    if (_impostorCount > maximumImpostors) {
      _validateImpostorCount();
      return;
    }

    final settings = ImpostorSettings(
      playerCount: _players.length,
      impostorCount: _impostorCount,
      categories:
          _selectedCategories.toList(),
      hintsEnabled: _hintsEnabled,
      randomImpostorCount:
          _randomImpostorCount,
      language: _language,
    );

    final round =
        ImpostorRoundGenerator.instance.generate(
      settings: settings,
      players: _players,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GameScreen(
          round: round,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme =
        Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IMPOSTOR',
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.all(16),
          children: [
            // ==========================================================
            // PLAYERS
            // ==========================================================

            _SectionTitle(
              title: 'Players',
              trailing:
                  '${_players.length}/${ImpostorSettings.maxPlayers}',
            ),

            const SizedBox(height: 10),

            InkWell(
              borderRadius:
                  BorderRadius.circular(16),
              onTap:
                  _openPlayerScreen,
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        alignment:
                            Alignment.center,
                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                          color: theme
                              .colorScheme
                              .primary
                              .withValues(
                            alpha: 0.12,
                          ),
                        ),
                        child: Text(
                          '${_players.length}',
                          style: theme
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_players.length} Players',
                              style: theme
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _players
                                  .take(3)
                                  .map(
                                    (player) =>
                                        player.name,
                                  )
                                  .join(', '),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: theme
                                  .textTheme
                                  .bodyMedium,
                            ),
                            if (_players.length > 3)
                              Text(
                                '+${_players.length - 3} more',
                                style: theme
                                    .textTheme
                                    .bodySmall,
                              ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================================
            // IMPOSTOR COUNT
            // ==========================================================

            _SectionTitle(
              title: 'Impostors',
              trailing: _randomImpostorCount
                  ? 'Up to $_impostorCount'
                  : '$_impostorCount selected',
            ),

            const SizedBox(height: 10),

            InkWell(
              borderRadius:
                  BorderRadius.circular(16),
              onTap:
                  _openImpostorCountScreen,
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        alignment:
                            Alignment.center,
                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                          color: theme
                              .colorScheme
                              .primary
                              .withValues(
                            alpha: 0.12,
                          ),
                        ),
                        child: Text(
                          '$_impostorCount',
                          style: theme
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              _randomImpostorCount
                                  ? 'Up to $_impostorCount Impostors'
                                  : _impostorCount == 1
                                      ? '1 Impostor'
                                      : '$_impostorCount Impostors',
                              style: theme
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              _randomImpostorCount
                                  ? 'Randomly chooses 0–$_impostorCount'
                                  : 'Choose exactly how many will sneak in',
                              style: theme
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================================
            // HINTS
            // ==========================================================

            Card(
              child: SwitchListTile(
                value:
                    _hintsEnabled,
                onChanged:
                    (value) {
                  setState(() {
                    _hintsEnabled =
                        value;
                  });
                },
                title:
                    const Text(
                  'Give hint to impostors',
                ),
                subtitle:
                    const Text(
                  'Only impostors will receive the hint',
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ==========================================================
            // CATEGORIES
            // ==========================================================

            _SectionTitle(
              title:
                  'Categories',
              trailing:
                  '${_selectedCategories.length}/${_categories.length}',
            ),

            const SizedBox(height: 10),

            InkWell(
              borderRadius:
                  BorderRadius.circular(16),
              onTap:
                  _openCategoryScreen,
              child: Card(
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        alignment:
                            Alignment.center,
                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                          color: theme
                              .colorScheme
                              .primary
                              .withValues(
                            alpha: 0.12,
                          ),
                        ),
                        child: const Icon(
                          Icons.category_rounded,
                          size: 30,
                        ),
                      ),

                      const SizedBox(
                        width: 16,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedCategories.length ==
                                      _categories.length
                                  ? 'All Categories'
                                  : '${_selectedCategories.length} Categories',
                              style: theme
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _selectedCategories
                                  .take(3)
                                  .join(', '),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: theme
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.chevron_right,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ==========================================================
            // START
            // ==========================================================

            SizedBox(
              height: 54,
              child: FilledButton(
                onPressed:
                    _startGame,
                child: const Text(
                  'START GAME',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    letterSpacing:
                        1,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================================
// SECTION TITLE
// ======================================================================

class _SectionTitle
    extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.trailing,
  });

  final String title;
  final String trailing;

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme =
        Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: theme
                .textTheme
                .titleMedium
                ?.copyWith(
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
        Text(
          trailing,
          style: theme
              .textTheme
              .bodyMedium,
        ),
      ],
    );
  }
}