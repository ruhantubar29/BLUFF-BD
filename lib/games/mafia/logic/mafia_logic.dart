import '../data/bn/roles.dart';

class MafiaGameLogic {
  final List<String> players;
  final List<MafiaRole> roles;

  final List<String> eliminatedPlayers = [];

  String? mafiaTarget;
  String? doctorTarget;
  String? detectiveTarget;

  MafiaGameLogic({
    required this.players,
    required this.roles,
  });

  MafiaRole getRole(String player) {
    final index = players.indexOf(player);

    if (index == -1) {
      throw Exception('Player not found');
    }

    return roles[index];
  }

  bool isAlive(String player) {
    return !eliminatedPlayers.contains(player);
  }

  List<String> get alivePlayers {
    return players
        .where((player) => isAlive(player))
        .toList();
  }

  List<String> get mafiaPlayers {
    return players.where((player) {
      return getRole(player).id == 'mafia';
    }).toList();
  }

  List<String> get aliveMafiaPlayers {
    return mafiaPlayers
        .where((player) => isAlive(player))
        .toList();
  }

  String? get eliminatedByNight {
    if (mafiaTarget == null) {
      return null;
    }

    if (mafiaTarget == doctorTarget) {
      return null;
    }

    return mafiaTarget;
  }

  void applyNightResult() {
    final victim = eliminatedByNight;

    if (victim != null &&
        !eliminatedPlayers.contains(victim)) {
      eliminatedPlayers.add(victim);
    }

    mafiaTarget = null;
    doctorTarget = null;
    detectiveTarget = null;
  }

  String? get winner {
    final aliveMafia = aliveMafiaPlayers.length;

    final aliveVillagers = alivePlayers.where((player) {
      return getRole(player).id != 'mafia';
    }).length;

    if (aliveMafia == 0) {
      return 'villagers';
    }

    if (aliveMafia >= aliveVillagers) {
      return 'mafia';
    }

    return null;
  }

  void eliminateByVote(String player) {
    if (!isAlive(player)) return;

    eliminatedPlayers.add(player);
  }
}