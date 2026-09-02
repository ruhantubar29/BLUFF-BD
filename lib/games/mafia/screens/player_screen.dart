import 'package:flutter/material.dart';

import '../data/bn/roles.dart';
import '../logic/mafia_logic.dart';
import 'night_screen.dart';

class MafiaPlayerScreen extends StatefulWidget {
  final List<String> players;
  final List<MafiaRole> roles;

  const MafiaPlayerScreen({
    super.key,
    required this.players,
    required this.roles,
  });

  @override
  State<MafiaPlayerScreen> createState() =>
      _MafiaPlayerScreenState();
}

class _MafiaPlayerScreenState
    extends State<MafiaPlayerScreen> {
  int currentPlayerIndex = 0;

  bool revealed = false;

  late final MafiaGameLogic gameLogic;

  @override
  void initState() {
    super.initState();

    gameLogic = MafiaGameLogic(
      players: widget.players,
      roles: widget.roles,
    );
  }

  void revealRole() {
    setState(() {
      revealed = true;
    });
  }

  void nextPlayer() {
    if (!revealed) return;

    if (currentPlayerIndex ==
        widget.players.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MafiaNightScreen(
            players: widget.players,
            roles: widget.roles,
            gameLogic: gameLogic,
            nightNumber: 1,
          ),
        ),
      );

      return;
    }

    setState(() {
      currentPlayerIndex++;
      revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final player =
        widget.players[currentPlayerIndex];

    final role =
        widget.roles[currentPlayerIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Mafia',
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
              const SizedBox(height: 25),

              Text(
                'PLAYER ${currentPlayerIndex + 1}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                player,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              Expanded(
                child: GestureDetector(
                  onTap: revealRole,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: revealed
                          ? _buildRole(role)
                          : _buildHidden(),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                revealed
                    ? 'Remember your role.'
                    : 'Only $player should look.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      revealed ? nextPlayer : null,
                  child: Text(
                    currentPlayerIndex ==
                            widget.players.length - 1
                        ? 'HIDE & START NIGHT'
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

  Widget _buildHidden() {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.lock_rounded,
          size: 65,
        ),

        const SizedBox(height: 25),

        const Text(
          'TAP TO REVEAL',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Make sure nobody else is looking.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildRole(MafiaRole role) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Text(
          role.emoji,
          style: const TextStyle(
            fontSize: 75,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          role.name,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15),

        Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text(
            role.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}