import 'package:flutter/material.dart';

import '../data/bn/roles.dart';
import '../logic/mafia_logic.dart';
import 'day_screen.dart';

class MafiaNightScreen extends StatefulWidget {
  final List<String> players;
  final List<MafiaRole> roles;
  final MafiaGameLogic gameLogic;
  final int nightNumber;

  const MafiaNightScreen({
    super.key,
    required this.players,
    required this.roles,
    required this.gameLogic,
    required this.nightNumber,
  });

  @override
  State<MafiaNightScreen> createState() =>
      _MafiaNightScreenState();
}

class _MafiaNightScreenState
    extends State<MafiaNightScreen> {
  int actionIndex = 0;

  String? selectedPlayer;

  List<String> get actionPlayers {
    final result = <String>[];

    for (int i = 0;
        i < widget.players.length;
        i++) {
      final player = widget.players[i];
      final role = widget.roles[i];

      if (!widget.gameLogic.isAlive(player)) {
        continue;
      }

      if (role.id == 'mafia' ||
          role.id == 'doctor' ||
          role.id == 'detective') {
        result.add(player);
      }
    }

    return result;
  }

  String get currentRoleId {
    final player =
        actionPlayers[actionIndex];

    return widget.gameLogic
        .getRole(player)
        .id;
  }

  String get currentPlayer {
    return actionPlayers[actionIndex];
  }

  void selectPlayer(String player) {
    setState(() {
      selectedPlayer = player;
    });
  }

  void confirmAction() {
    if (selectedPlayer == null) return;

    final role = currentRoleId;

    if (role == 'mafia') {
      widget.gameLogic.mafiaTarget =
          selectedPlayer;
    } else if (role == 'doctor') {
      widget.gameLogic.doctorTarget =
          selectedPlayer;
    } else if (role == 'detective') {
      widget.gameLogic.detectiveTarget =
          selectedPlayer;

      showDetectiveResult();
      return;
    }

    if (actionIndex ==
        actionPlayers.length - 1) {
      showNightResult();
      return;
    }

    setState(() {
      actionIndex++;
      selectedPlayer = null;
    });
  }

  void showDetectiveResult() {
    final target = selectedPlayer!;

    final isMafia =
        widget.gameLogic.getRole(target).id ==
            'mafia';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title:
              const Text('Investigation Result'),
          content: Text(
            isMafia
                ? '$target IS Mafia.'
                : '$target is NOT Mafia.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                if (actionIndex ==
                    actionPlayers.length - 1) {
                  showNightResult();
                  return;
                }

                setState(() {
                  actionIndex++;
                  selectedPlayer = null;
                });
              },
              child: const Text(
                'HIDE & PASS',
              ),
            ),
          ],
        );
      },
    );
  }

  void showNightResult() {
    final eliminated =
        widget.gameLogic.eliminatedByNight;

    widget.gameLogic.applyNightResult();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title:
              const Text('Night is over'),
          content: Text(
            eliminated == null
                ? 'Nobody was eliminated tonight.'
                : '$eliminated was eliminated.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        MafiaDayScreen(
                      players: widget.players,
                      roles: widget.roles,
                      gameLogic:
                          widget.gameLogic,
                      nightNumber:
                          widget.nightNumber,
                    ),
                  ),
                );
              },
              child: const Text(
                'START DAY',
              ),
            ),
          ],
        );
      },
    );
  }

  String get instruction {
    switch (currentRoleId) {
      case 'mafia':
        return 'Choose someone to eliminate.';
      case 'doctor':
        return 'Choose someone to save.';
      case 'detective':
        return 'Choose someone to investigate.';
      default:
        return '';
    }
  }

  String get roleTitle {
    switch (currentRoleId) {
      case 'mafia':
        return '🔪 MAFIA';
      case 'doctor':
        return '👨‍⚕️ DOCTOR';
      case 'detective':
        return '🕵️ DETECTIVE';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'NIGHT ${widget.nightNumber}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Text(
                roleTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                currentPlayer,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                instruction,
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child:
                    ListView.builder(
                  itemCount:
                      widget.players.length,
                  itemBuilder:
                      (context, index) {
                    final player =
                        widget.players[index];

                    final isCurrentPlayer =
                        player ==
                            currentPlayer;

                    final isAlive =
                        widget.gameLogic
                            .isAlive(player);

                    final isSelected =
                        player ==
                            selectedPlayer;

                    return Padding(
                      padding:
                          const EdgeInsets
                              .only(
                        bottom: 10,
                      ),
                      child: ListTile(
                        enabled: isAlive &&
                            !isCurrentPlayer,
                        onTap: isAlive
                            ? () =>
                                selectPlayer(
                                    player)
                            : null,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      16),
                          side: BorderSide(
                            color: isSelected
                                ? Theme.of(
                                    context)
                                    .colorScheme
                                    .primary
                                : Colors.grey
                                    .shade300,
                            width: isSelected
                                ? 2
                                : 1,
                          ),
                        ),
                        leading:
                            CircleAvatar(
                          child: Text(
                            '${index + 1}',
                          ),
                        ),
                        title: Text(
                          player,
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),
                        trailing:
                            isSelected
                                ? const Icon(
                                    Icons
                                        .check_circle,
                                  )
                                : null,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                width:
                    double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      selectedPlayer ==
                              null
                          ? null
                          : confirmAction,
                  child: Text(
                    actionIndex ==
                            actionPlayers
                                    .length -
                                1
                        ? 'END NIGHT'
                        : 'HIDE & PASS',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
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