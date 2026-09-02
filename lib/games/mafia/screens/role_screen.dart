import 'dart:math';

import 'package:flutter/material.dart';

import '../data/bn/roles.dart';
import 'player_screen.dart';

class MafiaRoleScreen extends StatefulWidget {
  final List<String> players;

  const MafiaRoleScreen({
    super.key,
    required this.players,
  });

  @override
  State<MafiaRoleScreen> createState() =>
      _MafiaRoleScreenState();
}

class _MafiaRoleScreenState
    extends State<MafiaRoleScreen> {
  late List<MafiaRole> assignedRoles;

  @override
  void initState() {
    super.initState();

    assignedRoles = _generateRoles();
  }

  List<MafiaRole> _generateRoles() {
    final count = widget.players.length;

    int mafiaCount;

    if (count <= 5) {
      mafiaCount = 1;
    } else if (count <= 8) {
      mafiaCount = 2;
    } else {
      mafiaCount = 3;
    }

    final roles = <MafiaRole>[];

    for (int i = 0; i < mafiaCount; i++) {
      roles.add(mafiaRoles[0]);
    }

    roles.add(mafiaRoles[1]);
    roles.add(mafiaRoles[2]);

    while (roles.length < count) {
      roles.add(mafiaRoles[3]);
    }

    roles.shuffle(Random());

    return roles;
  }

  void reshuffle() {
    setState(() {
      assignedRoles = _generateRoles();
    });
  }

  void startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MafiaPlayerScreen(
          players: widget.players,
          roles: assignedRoles,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final roleCounts = <String, int>{};

    for (final role in assignedRoles) {
      roleCounts[role.name] =
          (roleCounts[role.name] ?? 0) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mafia Roles',
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

              const Text(
                'ROLES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                '${widget.players.length} players',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ListView(
                  children:
                      roleCounts.entries.map((entry) {
                    final role =
                        mafiaRoles.firstWhere(
                      (role) =>
                          role.name == entry.key,
                    );

                    return Container(
                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),
                      padding:
                          const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color:
                              Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            role.emoji,
                            style:
                                const TextStyle(
                              fontSize: 32,
                            ),
                          ),

                          const SizedBox(width: 15),

                          Expanded(
                            child: Text(
                              role.name,
                              style:
                                  const TextStyle(
                                fontSize: 19,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          Text(
                            '×${entry.value}',
                            style:
                                const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: reshuffle,
                  child: const Text(
                    'RESHUFFLE',
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: startGame,
                  child: const Text(
                    'START',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
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
}