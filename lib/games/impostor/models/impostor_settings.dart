import '../../../core/language/app_language.dart';

class ImpostorSettings {
  static const int minPlayers = 3;
  static const int maxPlayers = 20;

  final int playerCount;
  final int impostorCount;
  final List<String> categories;
  final bool hintsEnabled;
  final bool randomImpostorCount;
  final AppLanguage language;

  const ImpostorSettings({
    required this.playerCount,
    required this.impostorCount,
    required this.categories,
    this.hintsEnabled = true,
    this.randomImpostorCount = false,
    this.language = AppLanguage.bangla,
  });

  ImpostorSettings copyWith({
    int? playerCount,
    int? impostorCount,
    List<String>? categories,
    bool? hintsEnabled,
    bool? randomImpostorCount,
    AppLanguage? language,
  }) {
    return ImpostorSettings(
      playerCount: playerCount ?? this.playerCount,
      impostorCount: impostorCount ?? this.impostorCount,
      categories: categories ?? this.categories,
      hintsEnabled: hintsEnabled ?? this.hintsEnabled,
      randomImpostorCount:
          randomImpostorCount ?? this.randomImpostorCount,
      language: language ?? this.language,
    );
  }
}