import 'package:flutter/material.dart';

import '../data/bn/roles.dart';
import '../logic/mafia_logic.dart';
import 'night_screen.dart';

class MafiaDayScreen extends StatefulWidget {
  final List<String> players;
  final List<MafiaRole> roles;
  final MafiaGameLogic gameLogic;
  final int nightNumber;

  const MafiaDayScreen({
    super.key,
    required this.players,
    required this.roles,
    required this.gameLogic,
    required this.nightNumber,
  });

  @override
  State<MafiaDayScreen> createState() =>
      _MafiaDayScreenState();
}

class _MafiaDayScreenState
    extends State<MafiaDayScreen> {
  int voterIndex = 0;

  String? selectedPlayer;

  final Map<String, int> votes = {};

  List<String> get alivePlayers {
    return widget.gameLogic.alivePlayers;
  }

  String get currentVoter {
    return alivePlayers[voterIndex];
  }

  void selectPlayer(String player) {
    if (player == currentVoter) return;

    setState(() {
      selectedPlayer = player;
    });
  }

  void confirmVote() {
    if (selectedPlayer == null) return;

    final target = selectedPlayer!;

    votes[target] = (votes[target] ?? 0) + 1;

    if (voterIndex >= alivePlayers.length - 1) {
      finishVoting();
      return;
    }

    setState(() {
      voterIndex++;
      selectedPlayer = null;
    });
  }

  void finishVoting() {
    String? eliminated;
    int highestVotes = 0;
    bool tie = false;

    for (final entry in votes.entries) {
      if (entry.value > highestVotes) {
        highestVotes = entry.value;
        eliminated = entry.key;
        tie = false;
      } else if (entry.value == highestVotes &&
          highestVotes > 0) {
        tie = true;
      }
    }

    if (tie) {
      eliminated = null;
    }

    if (eliminated != null) {
      widget.gameLogic.eliminateByVote(
        eliminated,
      );
    }

    final winner = widget.gameLogic.winner;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text('Voting Result'),
          content: Text(
            tie
                ? 'The vote is tied.\n\nNobody is eliminated.'
                : eliminated == null
                    ? 'Nobody was eliminated.'
                    : '$eliminated was eliminated.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                if (winner != null) {
                  showWinner(winner);
                } else {
                  startNextNight();
                }
              },
              child: Text(
                winner != null
                    ? 'SEE WINNER'
                    : 'START NIGHT',
              ),
            ),
          ],
        );
      },
    );
  }

  void startNextNight() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MafiaNightScreen(
          players: widget.players,
          roles: widget.roles,
          gameLogic: widget.gameLogic,
          nightNumber: widget.nightNumber + 1,
        ),
      ),
    );
  }

  void showWinner(String winner) {
    final mafiaWon = winner == 'mafia';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: Text(
            mafiaWon
                ? '🔪 Mafia Wins!'
                : '🧑 Villagers Win!',
          ),
          content: Text(
            mafiaWon
                ? 'The Mafia has taken control.'
                : 'All Mafia members have been eliminated.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: const Text('BACK TO HOME'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'DAY ${widget.nightNumber}',
          style: const TextStyle(
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

              const Text(
                '☀️',
                style: TextStyle(
                  fontSize: 65,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'DISCUSSION & VOTE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                '$currentVoter, cast your vote.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: alivePlayers.length,
                  itemBuilder: (context, index) {
                    final player =
                        alivePlayers[index];

                    final isCurrentVoter =
                        player == currentVoter;

                    final isSelected =
                        player == selectedPlayer;

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: ListTile(
                        enabled: !isCurrentVoter,
                        onTap: isCurrentVoter
                            ? null
                            : () =>
                                selectPlayer(player),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                : Colors.grey
                                    .shade300,
                            width:
                                isSelected ? 2 : 1,
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Text(
                            '${index + 1}',
                          ),
                        ),
                        title: Text(
                          player,
                          style: const TextStyle(
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                        subtitle: isCurrentVoter
                            ? const Text(
                                'You cannot vote for yourself',
                              )
                            : null,
                        trailing: isSelected
                            ? const Icon(
                                Icons
                                    .how_to_vote_rounded,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: selectedPlayer == null
                      ? null
                      : confirmVote,
                  child: Text(
                    voterIndex ==
                            alivePlayers.length - 1
                        ? 'END VOTING'
                        : 'HIDE & PASS',
                    style: const TextStyle(
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