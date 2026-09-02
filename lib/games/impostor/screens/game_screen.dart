import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/impostor_round.dart';
import '../models/impostor_player.dart';
import 'vote_screen.dart';

const _highlight = Color(0xffFFD166);
const _coverRed = Color(0xffC62828);

class GameScreen extends StatefulWidget {
  const GameScreen({
    super.key,
    required this.round,
  });

  final ImpostorRound round;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {
  late final AnimationController revealController;
  late final AnimationController slideController;

  late final List<int> revealOrder;
  late final List<int> characterIndexes;

  int step = 0;
  bool hasRevealedOnce = false;
  bool isTransitioning = false;
  int? outgoingStep;

  ImpostorRound get round => widget.round;

  int get currentPlayerIndex => revealOrder[step];

  ImpostorPlayer get currentPlayer =>
      round.players[currentPlayerIndex];

  bool get isLastPlayer =>
      step == revealOrder.length - 1;

  bool get showNextButton =>
      hasRevealedOnce &&
      revealController.value < 0.01 &&
      !isTransitioning;

  @override
  void initState() {
    super.initState();

    revealOrder = List<int>.generate(
      round.players.length,
      (index) => index,
    )..shuffle(Random());

    characterIndexes =
        _buildCharacterIndexes(round.players.length);

    revealController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 450,
      ),
    );

    revealController.addListener(() {
      if (revealController.value >= 0.65 &&
          !hasRevealedOnce) {
        setState(() {
          hasRevealedOnce = true;
        });
      }
    });

    slideController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 380,
      ),
    );
  }

  @override
  void dispose() {
    revealController.dispose();
    slideController.dispose();
    super.dispose();
  }

  // --------------------------------------------------
  // CHARACTER DECK
  // --------------------------------------------------

  static List<int> _buildCharacterIndexes(
    int playerCount,
  ) {
    final rng = Random();

    final result = <int>[];
    var bag = <int>[];

    for (var i = 0; i < playerCount; i++) {
      if (bag.isEmpty) {
        bag = List<int>.generate(
          5,
          (index) => index,
        )..shuffle(rng);
      }

      result.add(
        bag.removeAt(0),
      );
    }

    return result;
  }

  // --------------------------------------------------
  // DRAG
  // --------------------------------------------------

  void _onDragUpdate(
    DragUpdateDetails details,
    double height,
  ) {
    final delta =
        -details.delta.dy / (height * 0.55);

    revealController.value =
        (revealController.value + delta)
            .clamp(0.0, 1.0);
  }

  void _onDragEnd(DragEndDetails details) {
    revealController.animateBack(
      0,
      duration: const Duration(
        milliseconds: 420,
      ),
      curve: Curves.bounceOut,
    );
  }

  // --------------------------------------------------
  // NEXT PLAYER
  // --------------------------------------------------

  void nextPlayer() {
    if (isLastPlayer) {
      _showRoundReady();
      return;
    }

    setState(() {
      outgoingStep = step;
      isTransitioning = true;
    });

    slideController.forward(from: 0).then((_) {
      if (!mounted) return;

      setState(() {
        step++;
        hasRevealedOnce = false;
        revealController.value = 0;
        isTransitioning = false;
        outgoingStep = null;
      });

      slideController.value = 0;
    });
  }

  // --------------------------------------------------
  // BUILD
  // --------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final cardHeight =
        (MediaQuery.of(context).size.height * 0.52)
            .clamp(480.0, 580.0);

    return Scaffold(
      body: _buildBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 18,
            ),
            child: Column(
              children: [
                // HEADER
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${step + 1} / ${revealOrder.length}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // CARD
                SizedBox(
                  height: cardHeight,
                  child: isTransitioning
                      ? _buildSlideTransition(
                          cardHeight,
                        )
                      : _buildRevealCard(
                          cardHeight,
                        ),
                ),

                const SizedBox(height: 22),

                // NEXT
                AnimatedBuilder(
                  animation: Listenable.merge([
                    revealController,
                    slideController,
                  ]),
                  builder: (context, _) {
                    return SizedBox(
                      height: 64,
                      child: showNextButton
                          ? _NextButton(
                              label: isLastPlayer
                                  ? 'আলোচনা শুরু করো'
                                  : 'পরের জন',
                              onTap: nextPlayer,
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------
  // BACKGROUND
  // --------------------------------------------------

  Widget _buildBackground({
    required Widget child,
  }) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff171722),
            Color(0xff09090E),
          ],
        ),
      ),
      child: child,
    );
  }

  // --------------------------------------------------
  // REVEAL CARD
  // --------------------------------------------------

  Widget _buildRevealCard(double height) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: (details) {
        _onDragUpdate(
          details,
          height,
        );
      },
      onVerticalDragEnd: _onDragEnd,
      onVerticalDragCancel: () {
        _onDragEnd(
          DragEndDetails(),
        );
      },
      child: AnimatedBuilder(
        animation: revealController,
        builder: (context, child) {
          final movement = height *
              0.72 *
              Curves.easeOutCubic.transform(
                revealController.value,
              );

          return Stack(
            clipBehavior: Clip.none,
            children: [
              _buildUnderCard(height),

              Transform.translate(
                offset: Offset(
                  0,
                  -movement,
                ),
                child: _buildCoverCard(
                  height: height,
                  playerName:
                      currentPlayer.name,
                  imageIndex:
                      characterIndexes[
                          currentPlayerIndex],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // --------------------------------------------------
  // SECRET CARD
  // --------------------------------------------------

  Widget _buildUnderCard(double height) {
    final isImpostor =
        round.isImpostor(
      currentPlayerIndex,
    );

    return Container(
      height: height,
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius:
            BorderRadius.circular(28),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isImpostor) ...[
              const Text(
                'তোমার শব্দ',
                style: TextStyle(
                  fontFamily: 'Ashalota',
                  fontSize: 17,
                  color: Colors.white54,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                round.secretWord,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Ashalota',
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else ...[
              const Text(
                'তুমিই IMPOSTOR!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Ashalota',
                  fontSize: 31,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (round.hint != null &&
                  round.hint!.isNotEmpty) ...[
                const SizedBox(height: 20),

                Text(
                  'ইঙ্গিতঃ ${round.hint}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Ashalota',
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // PLAYER TRANSITION
  // --------------------------------------------------

  Widget _buildSlideTransition(
    double height,
  ) {
    final outgoingIndex =
        revealOrder[outgoingStep!];

    final incomingIndex =
        revealOrder[step + 1];

    final outgoingName =
        round.players[outgoingIndex].name;

    final incomingName =
        round.players[incomingIndex].name;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final t =
            Curves.easeInOutCubic.transform(
          slideController.value,
        );

        return ClipRRect(
          borderRadius:
              BorderRadius.circular(28),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              FractionalTranslation(
                translation: Offset(
                  -t,
                  0,
                ),
                child: _buildCoverCard(
                  height: height,
                  playerName:
                      outgoingName,
                  imageIndex:
                      characterIndexes[
                          outgoingIndex],
                ),
              ),

              FractionalTranslation(
                translation: Offset(
                  1 - t,
                  0,
                ),
                child: _buildCoverCard(
                  height: height,
                  playerName:
                      incomingName,
                  imageIndex:
                      characterIndexes[
                          incomingIndex],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --------------------------------------------------
  // COVER CARD
  // --------------------------------------------------

  Widget _buildCoverCard({
    required double height,
    required String playerName,
    required int imageIndex,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: _coverRed,
        borderRadius:
            BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(26),
        child: Stack(
          children: [
            // CHARACTER
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Transform.scale(
                  scale: 1.1,
                  child: Image.asset(
                    'assets/images/characters/'
                    'character_${imageIndex + 1}.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),

            // BOTTOM FOG
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 190,
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin:
                          Alignment.topCenter,
                      end:
                          Alignment.bottomCenter,
                      colors: [
                        _coverRed.withValues(
                          alpha: 0.0,
                        ),
                        _coverRed.withValues(
                          alpha: 0.35,
                        ),
                        _coverRed.withValues(
                          alpha: 0.80,
                        ),
                        _coverRed,
                      ],
                      stops: const [
                        0.0,
                        0.30,
                        0.55,
                        0.8,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // PLAYER NAME
            Positioned(
              top: 20,
              left: 18,
              right: 18,
              child: Text(
                playerName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Ashalota',
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // INSTRUCTION
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Column(
                mainAxisSize:
                    MainAxisSize.min,
                children: const [
                  Icon(
                    Icons
                        .keyboard_arrow_up_rounded,
                    size: 42,
                    color: Colors.white,
                  ),
                  Text(
                    'উপরে টেনে দেখুন',
                    style: TextStyle(
                      fontFamily:
                          'Ashalota',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------------------------------
  // FINISHED REVEAL
  // --------------------------------------------------

  void _showRoundReady() {
    final startingPlayerIndex =
        round.startingPlayerIndex;

    final startingPlayer =
        startingPlayerIndex == null
            ? null
            : round.players[
                startingPlayerIndex];

    showModalBottomSheet(
      context: context,
      backgroundColor:
          const Color(0xff171722),
      isDismissible: false,
      enableDrag: false,
      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.all(24),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Icon(
                  Icons.play_circle_fill_rounded,
                  color: _highlight,
                  size: 52,
                ),

                const SizedBox(height: 16),

                const Text(
                  'আলোচনা শুরু!',
                  style: TextStyle(
                    fontFamily:
                        'Ashalota',
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                if (startingPlayer != null)
                  Text(
                    '${startingPlayer.name} will start',
                    textAlign:
                        TextAlign.center,
                    style: const TextStyle(
                      fontFamily:
                          'Ashalota',
                      color: Colors.white70,
                      fontSize: 19,
                    ),
                  ),

                const SizedBox(height: 24),

                SizedBox(
                  width:
                      double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              VoteScreen(
                            round: round,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'VOTE NOW',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ==================================================
// NEXT BUTTON
// ==================================================

class _NextButton
    extends StatefulWidget {
  const _NextButton({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  State<_NextButton> createState() =>
      _NextButtonState();
}

class _NextButtonState
    extends State<_NextButton>
    with TickerProviderStateMixin {
  late final AnimationController entrance;
  late final AnimationController idle;

  Timer? idleDelayTimer;

  @override
  void initState() {
    super.initState();

    entrance =
        AnimationController(
      vsync: this,
      duration:
          const Duration(
        milliseconds: 380,
      ),
    )..forward();

    idle =
        AnimationController(
      vsync: this,
      duration:
          const Duration(
        milliseconds: 650,
      ),
    );

    idleDelayTimer = Timer(
      const Duration(
        milliseconds: 500,
      ),
      () {
        if (mounted) {
          idle.repeat(
            reverse: true,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    idleDelayTimer?.cancel();
    entrance.dispose();
    idle.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        entrance,
        idle,
      ]),
      builder:
          (context, child) {
        final scale =
            entrance.isCompleted
                ? 1 +
                    (idle.value * 0.06)
                : Curves.easeOutBack
                    .transform(
                    entrance.value,
                  );

        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(
            22,
          ),
          onTap: widget.onTap,
          child: Ink(
            decoration:
                BoxDecoration(
              color: Colors.white
                  .withValues(
                alpha: .08,
              ),
              borderRadius:
                  BorderRadius.circular(
                22,
              ),
            ),
            child: Container(
              width:
                  double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 18,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [
                  const Icon(
                    Icons
                        .arrow_forward_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.label,
                    style:
                        const TextStyle(
                      fontFamily:
                          'Ashalota',
                      fontSize: 19,
                      color:
                          Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}