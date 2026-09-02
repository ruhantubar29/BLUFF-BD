import 'impostor_player.dart';

class ImpostorRound {
  final List<ImpostorPlayer> players;

  final String category;
  final String secretWord;
  final String? hint;

  final Set<int> impostorIndexes;

  final bool randomImpostorCount;

  int? startingPlayerIndex;

  ImpostorRound({
    required this.players,
    required this.category,
    required this.secretWord,
    required this.impostorIndexes,
    required this.randomImpostorCount,
    this.hint,
    this.startingPlayerIndex,
  });

  bool isImpostor(int playerIndex) {
    return impostorIndexes.contains(playerIndex);
  }

  List<int> get alivePlayerIndexes {
    final result = <int>[];

    for (int i = 0; i < players.length; i++) {
      if (players[i].isAlive) {
        result.add(i);
      }
    }

    return result;
  }

  bool get allImpostorsCaught {
    return impostorIndexes.every(
      (index) => !players[index].isAlive,
    );
  }

  int get aliveImpostorCount {
    return impostorIndexes.where(
      (index) => players[index].isAlive,
    ).length;
  }
}