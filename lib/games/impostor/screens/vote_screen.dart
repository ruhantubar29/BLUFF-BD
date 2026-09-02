import 'dart:async';

import 'package:flutter/material.dart';

import '../models/impostor_round.dart';

const _red = Color(0xffC62828);
const _dark = Color(0xff09090E);
const _highlight = Color(0xffFFD166);

class VoteScreen extends StatefulWidget {
  const VoteScreen({
    super.key,
    required this.round,
  });

  final ImpostorRound round;

  @override
  State<VoteScreen> createState() =>
      _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen>
    with TickerProviderStateMixin {
  final Set<int> _selectedPlayers = {};

  bool _showingEjection = false;
  bool _showingPlayerResult = false;
  bool _showingFinalResult = false;
  bool _showingNoImpostor = false;

  List<int> _votedPlayers = [];

  late final AnimationController _ejectionController;
  late final AnimationController _resultController;

  Timer? _ejectionTimer;

  ImpostorRound get round => widget.round;

  bool get isRandomMode {
    return round.randomImpostorCount;
  }

  int get actualImpostorCount {
    return round.impostorIndexes.length;
  }

  int get remainingImpostors {
    return round.aliveImpostorCount;
  }

  @override
  void initState() {
    super.initState();

    _ejectionController =
        AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 650,
      ),
    );

    _resultController =
        AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    if (isRandomMode &&
        actualImpostorCount == 0) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (!mounted) {
            return;
          }

          setState(() {
            _showingNoImpostor = true;
          });

          _resultController.forward(from: 0);
        },
      );
    }
  }

  @override
  void dispose() {
    _ejectionTimer?.cancel();
    _ejectionController.dispose();
    _resultController.dispose();
    super.dispose();
  }

  int get maximumVotes {
    if (isRandomMode) {
      return 1;
    }

    return actualImpostorCount;
  }

  void _selectPlayer(int playerIndex) {
    if (_showingEjection ||
        _showingPlayerResult ||
        _showingFinalResult ||
        _showingNoImpostor) {
      return;
    }

    setState(() {
      if (_selectedPlayers.contains(playerIndex)) {
        _selectedPlayers.remove(playerIndex);
        return;
      }

      if (_selectedPlayers.length >= maximumVotes) {
        if (isRandomMode) {
          _selectedPlayers.clear();
        } else {
          return;
        }
      }

      _selectedPlayers.add(playerIndex);
    });
  }

  void _vote() {
    if (_selectedPlayers.isEmpty ||
        _showingEjection ||
        _showingPlayerResult ||
        _showingFinalResult ||
        _showingNoImpostor) {
      return;
    }

    _votedPlayers =
        _selectedPlayers.toList();

    setState(() {
      _showingEjection = true;
    });

    _ejectionController.forward(from: 0);

    _ejectionTimer = Timer(
      const Duration(
        milliseconds: 1800,
      ),
      () {
        if (!mounted) {
          return;
        }

        for (final playerIndex
            in _votedPlayers) {
          round.players[playerIndex].isAlive =
              false;
        }

        setState(() {
          _showingEjection = false;
          _showingPlayerResult = true;
        });

        _resultController.forward(from: 0);
      },
    );
  }

  bool _wasImpostor(int playerIndex) {
    return round.isImpostor(playerIndex);
  }

  bool get everyVotedPlayerWasImpostor {
    return _votedPlayers.every(
      _wasImpostor,
    );
  }

  bool get anyVotedPlayerWasImpostor {
    return _votedPlayers.any(
      _wasImpostor,
    );
  }

  void _continueRandomVoting() {
    setState(() {
      _selectedPlayers.clear();
      _votedPlayers.clear();
      _showingPlayerResult = false;
    });

    _resultController.reset();
  }

  void _finishGame() {
    setState(() {
      _showingPlayerResult = false;
      _showingFinalResult = true;
    });

    _resultController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    if (_showingNoImpostor) {
      return _buildNoImpostorScreen();
    }

    if (_showingEjection) {
      return _buildEjectionScreen();
    }

    if (_showingPlayerResult) {
      return _buildPlayerResultScreen();
    }

    if (_showingFinalResult) {
      return _buildFinalResultScreen();
    }

    return _buildVoteScreen();
  }

  Widget _buildVoteScreen() {
    final alivePlayers =
        round.alivePlayerIndexes;

    final requiredVotes =
        maximumVotes;

    return Scaffold(
      backgroundColor: _dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            18,
            20,
            20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Text(
                      'VOTE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                isRandomMode
                    ? 'Vote for the suspected impostor'
                    : 'Select $requiredVotes player'
                        '${requiredVotes == 1 ? '' : 's'}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                isRandomMode
                    ? 'One player at a time'
                    : '${_selectedPlayers.length}/$requiredVotes selected',
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: alivePlayers.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final playerIndex =
                        alivePlayers[index];

                    final player =
                        round.players[playerIndex];

                    final selected =
                        _selectedPlayers.contains(
                      playerIndex,
                    );

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: _PlayerVoteCard(
                        name: player.name,
                        number: index + 1,
                        selected: selected,
                        onTap: () {
                          _selectPlayer(
                            playerIndex,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed:
                      _selectedPlayers.length ==
                              requiredVotes
                          ? _vote
                          : null,
                  child: Text(
                    isRandomMode
                        ? 'VOTE'
                        : 'VOTE ${_selectedPlayers.length}/$requiredVotes',
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEjectionScreen() {
    final names = _votedPlayers
        .map(
          (index) => round.players[index].name,
        )
        .toList();

    final title = names.length == 1
        ? names.first
        : names.length == 2
            ? '${names[0]} and ${names[1]}'
            : '${names.sublist(0, names.length - 1).join(', ')} and ${names.last}';

    return Scaffold(
      backgroundColor: _dark,
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _ejectionController,
            builder: (context, child) {
              final t =
                  Curves.easeInOutCubic
                      .transform(
                _ejectionController.value,
              );

              final scale =
                  1.0 - (t * 0.12);

              final opacity =
                  1.0 - (t * 0.25);

              return Opacity(
                opacity: opacity,
                child: Transform.scale(
                  scale: scale,
                  child: child,
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.person_remove_rounded,
                  color: _red,
                  size: 72,
                ),
                const SizedBox(height: 26),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'has been voted out...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 21,
                  ),
                ),
                const SizedBox(height: 24),
                const _LoadingDots(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerResultScreen() {
    final allCorrect =
        everyVotedPlayerWasImpostor;

    return Scaffold(
      backgroundColor: _dark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(24),
            child: AnimatedBuilder(
              animation: _resultController,
              builder: (context, child) {
                final scale =
                    Curves.easeOutBack.transform(
                  _resultController.value,
                );

                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    allCorrect
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: allCorrect
                        ? _highlight
                        : _red,
                    size: 78,
                  ),
                  const SizedBox(height: 22),
                  ..._buildVotedPlayerResults(),
                  const SizedBox(height: 30),
                  if (allCorrect &&
                      isRandomMode &&
                      remainingImpostors > 0) ...[
                    Text(
                      remainingImpostors == 1
                          ? '1 IMPOSTOR REMAINS'
                          : '$remainingImpostors IMPOSTORS REMAIN',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: _highlight,
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Discuss again and vote.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton(
                        onPressed:
                            _continueRandomVoting,
                        child: const Text(
                          'DISCUSS AGAIN',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton(
                        onPressed: _finishGame,
                        child: const Text(
                          'SEE RESULT',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildVotedPlayerResults() {
    final widgets = <Widget>[];

    for (int i = 0;
        i < _votedPlayers.length;
        i++) {
      final playerIndex =
          _votedPlayers[i];

      final player =
          round.players[playerIndex];

      final wasImpostor =
          _wasImpostor(playerIndex);

      widgets.add(
        Text(
          player.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 31,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      widgets.add(
        const SizedBox(height: 8),
      );

      widgets.add(
        Text(
          wasImpostor
              ? 'WAS THE IMPOSTOR!'
              : 'WAS NOT THE IMPOSTOR!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: wasImpostor
                ? _highlight
                : _red,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

      if (i != _votedPlayers.length - 1) {
        widgets.add(
          const SizedBox(height: 24),
        );
      }
    }

    return widgets;
  }

  Widget _buildNoImpostorScreen() {
    return Scaffold(
      backgroundColor: _dark,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.all(24),
            child: AnimatedBuilder(
              animation: _resultController,
              builder: (context, child) {
                final scale =
                    Curves.easeOutBack.transform(
                  _resultController.value,
                );

                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_rounded,
                    color: _highlight,
                    size: 86,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'NO IMPOSTOR WAS HERE!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'There was no impostor this round.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 34),
                  const Text(
                    'EVERYONE WINS!',
                    style: TextStyle(
                      color: _highlight,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _finishButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFinalResultScreen() {
    final playersWon =
        round.allImpostorsCaught;

    return Scaffold(
      backgroundColor: _dark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.all(24),
            child: AnimatedBuilder(
              animation: _resultController,
              builder: (context, child) {
                final scale =
                    Curves.easeOutBack.transform(
                  _resultController.value,
                );

                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    playersWon
                        ? Icons.emoji_events_rounded
                        : Icons.dangerous_rounded,
                    color: playersWon
                        ? _highlight
                        : _red,
                    size: 82,
                  ),
                  const SizedBox(height: 22),
                  Text(
                    playersWon
                        ? 'EVERYONE WINS!'
                        : 'EVERYONE LOSES!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: playersWon
                          ? _highlight
                          : _red,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'THE IMPOSTORS WERE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  ..._buildAllImpostors(),
                  const SizedBox(height: 34),
                  _finishButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAllImpostors() {
    final widgets = <Widget>[];

    for (final playerIndex
        in round.impostorIndexes) {
      final player =
          round.players[playerIndex];

      widgets.add(
        Container(
          width: double.infinity,
          margin:
              const EdgeInsets.only(bottom: 12),
          padding:
              const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.07,
            ),
            borderRadius:
                BorderRadius.circular(18),
            border: Border.all(
              color: _red.withValues(
                alpha: 0.35,
              ),
            ),
          ),
          child: Column(
            children: [
              Text(
                player.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (round.hint != null &&
                  round.hint!.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  'Hint: ${round.hint}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 17,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _finishButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: const Text(
          'FINISH',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}

class _PlayerVoteCard
    extends StatelessWidget {
  const _PlayerVoteCard({
    required this.name,
    required this.number,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final int number;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(20),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: selected
                ? _red.withValues(
                    alpha: 0.25,
                  )
                : Colors.white.withValues(
                    alpha: 0.07,
                  ),
            borderRadius:
                BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? _red
                  : Colors.white.withValues(
                      alpha: 0.10,
                    ),
              width: selected ? 2 : 1,
            ),
          ),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 17,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: selected
                    ? _red
                    : Colors.white.withValues(
                        alpha: 0.10,
                      ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                selected
                    ? Icons
                        .radio_button_checked_rounded
                    : Icons
                        .radio_button_unchecked_rounded,
                color: selected
                    ? _red
                    : Colors.white38,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingDots
    extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() =>
      _LoadingDotsState();
}

class _LoadingDotsState
    extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final count =
            ((_controller.value * 4).floor() %
                4);

        return Text(
          '.' * count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}