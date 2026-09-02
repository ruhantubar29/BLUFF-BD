class ImpostorPlayer {
  final String name;

  bool isAlive;

  ImpostorPlayer({
    required this.name,
    this.isAlive = true,
  });

  ImpostorPlayer copyWith({
    String? name,
    bool? isAlive,
  }) {
    return ImpostorPlayer(
      name: name ?? this.name,
      isAlive: isAlive ?? this.isAlive,
    );
  }
}