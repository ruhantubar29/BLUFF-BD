import 'package:flutter/material.dart';
import '../logic/game_logic.dart';

class WhoAmIGameScreen extends StatefulWidget {
  final List<String> players;
  final List<String> selectedCategories;

  const WhoAmIGameScreen({
    super.key,
    required this.players,
    required this.selectedCategories,
  });

  @override
  State<WhoAmIGameScreen> createState() =>
      _WhoAmIGameScreenState();
}

class _WhoAmIGameScreenState extends State<WhoAmIGameScreen> {
  late WhoAmIGameLogic game;

  int currentPlayerIndex = 0;

  bool revealed = false;

  @override
  void initState() {
    super.initState();

    game = WhoAmIGameLogic(
      playerNames: widget.players,
      selectedCategories: widget.selectedCategories,
    );
  }

  void reveal() {
    setState(() {
      revealed = true;
    });
  }

  void nextPlayer() {
    if (currentPlayerIndex >= game.players.length - 1) {
      // For now, return to the previous screen
      // after everyone has seen the identities.
      Navigator.pop(context);
      return;
    }

    setState(() {
      currentPlayerIndex++;
      revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayer =
        game.getPlayer(currentPlayerIndex);

    final otherPlayers =
        game.getOtherPlayers(currentPlayerIndex);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Who Am I?',
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
              const SizedBox(height: 10),

              Text(
                currentPlayer.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'This is your turn',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: GestureDetector(
                  onVerticalDragUpdate: (details) {
                    if (details.delta.dy < -5) {
                      reveal();
                    }
                  },
                  onTap: reveal,
                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 350),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(24),
                      border: Border.all(
                        width: 2,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                      color: Theme.of(context)
                          .colorScheme
                          .surface,
                    ),
                    child: revealed
                        ? _buildRevealedContent(
                            otherPlayers,
                          )
                        : _buildHiddenContent(
                            currentPlayer.name,
                          ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      revealed ? nextPlayer : null,
                  child: Text(
                    currentPlayerIndex ==
                            game.players.length - 1
                        ? 'START GAME'
                        : 'NEXT PERSON',
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

  Widget _buildHiddenContent(String playerName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.lock_rounded,
          size: 55,
        ),

        const SizedBox(height: 25),

        Text(
          playerName,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 20),

        const Icon(
          Icons.keyboard_arrow_up_rounded,
          size: 40,
        ),

        const SizedBox(height: 5),

        Text(
          'Drag up to reveal',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildRevealedContent(
    List<WhoAmIPlayer> otherPlayers,
  ) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'OTHER PLAYERS',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.separated(
              itemCount: otherPlayers.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 30),
              itemBuilder: (context, index) {
                final player =
                    otherPlayers[index];

                return Row(
                  children: [
                    const Icon(
                      Icons.person_rounded,
                      size: 32,
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            player.identity.name,
                            style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const Center(
            child: Text(
              'Remember these identities!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}