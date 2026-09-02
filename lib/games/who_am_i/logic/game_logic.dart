import 'dart:math';

import '../data/bn/identities.dart';

class WhoAmIPlayer {
  final String name;
  final WhoAmIIdentity identity;

  const WhoAmIPlayer({
    required this.name,
    required this.identity,
  });
}

class WhoAmIGameLogic {
  final List<String> playerNames;
  final List<String> selectedCategories;

  late final List<WhoAmIPlayer> players;

  WhoAmIGameLogic({
    required this.playerNames,
    required this.selectedCategories,
  }) {
    _assignIdentities();
  }

  void _assignIdentities() {
    final availableIdentities = whoAmIIdentities
        .where(
          (identity) =>
              selectedCategories.contains(identity.category),
        )
        .toList();

    availableIdentities.shuffle(Random());

    if (availableIdentities.length < playerNames.length) {
      throw Exception(
        'Not enough identities for all players.',
      );
    }

    players = List.generate(
      playerNames.length,
      (index) {
        return WhoAmIPlayer(
          name: playerNames[index],
          identity: availableIdentities[index],
        );
      },
    );
  }

  WhoAmIPlayer getPlayer(int index) {
    return players[index];
  }

  List<WhoAmIPlayer> getOtherPlayers(int currentPlayerIndex) {
    return players
        .where(
          (player) =>
              player != players[currentPlayerIndex],
        )
        .toList();
  }
}