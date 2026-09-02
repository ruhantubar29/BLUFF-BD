import 'package:flutter/material.dart';

class ImpostorCountScreen extends StatefulWidget {
  const ImpostorCountScreen({
    super.key,
    required this.playerCount,
    required this.selectedCount,
    this.randomEnabled = false,
  });

  final int playerCount;
  final int selectedCount;
  final bool randomEnabled;

  @override
  State<ImpostorCountScreen> createState() =>
      _ImpostorCountScreenState();
}

class _ImpostorCountScreenState
    extends State<ImpostorCountScreen> {
  late bool _randomEnabled;
  late int _selectedCount;

  @override
  void initState() {
    super.initState();

    _randomEnabled = widget.randomEnabled;
    _selectedCount = widget.selectedCount;

    final maximum = _maximumImpostors(
      widget.playerCount,
    );

    if (_selectedCount < 1 ||
        _selectedCount > maximum) {
      _selectedCount = 1;
    }
  }

  int _maximumImpostors(int players) {
    if (players >= 16) {
      return 6;
    }

    if (players >= 13) {
      return 5;
    }

    if (players >= 10) {
      return 4;
    }

    if (players >= 7) {
      return 3;
    }

    if (players >= 5) {
      return 2;
    }

    return 1;
  }

  int _minimumPlayersFor(int impostors) {
    switch (impostors) {
      case 1:
        return 3;
      case 2:
        return 5;
      case 3:
        return 7;
      case 4:
        return 10;
      case 5:
        return 13;
      case 6:
        return 16;
      default:
        return 3;
    }
  }

  bool _isAvailable(int count) {
    return count <=
        _maximumImpostors(widget.playerCount);
  }

  void _selectCount(int count) {
    if (!_isAvailable(count)) {
      return;
    }

    setState(() {
      _selectedCount = count;
    });
  }

  void _toggleRandom(bool value) {
    setState(() {
      _randomEnabled = value;

      final maximum = _maximumImpostors(
        widget.playerCount,
      );

      if (_selectedCount > maximum) {
        _selectedCount = maximum;
      }

      if (_selectedCount > 3) {
        _selectedCount = 3;
      }
    });
  }

  void _done() {
    Navigator.pop(
      context,
      ImpostorCountSelection(
        count: _selectedCount,
        randomEnabled: _randomEnabled,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    splashRadius: 24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Impostors',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              _GlassCard(
                radius: 22,
                child: SwitchListTile(
                  value: _randomEnabled,
                  onChanged: _toggleRandom,
                  activeThumbColor: Colors.white,
                  activeTrackColor: Colors.white24,
                  inactiveThumbColor: Colors.white54,
                  inactiveTrackColor: Colors.white12,
                  title: const Text(
                    'Random impostor count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    _randomEnabled
                        ? 'The game can have 0 to the selected maximum'
                        : 'Choose exactly how many impostors will sneak in',
                    style: const TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _randomEnabled
                      ? 'Maximum impostors'
                      : 'Number of impostors',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  itemCount: _randomEnabled ? 3 : 6,
                  itemBuilder: (context, index) {
                    final count = index + 1;
                    final available =
                        _isAvailable(count);
                    final selected =
                        _selectedCount == count;

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: _CountCard(
                        count: count,
                        selected: selected,
                        available: available,
                        randomEnabled: _randomEnabled,
                        minimumPlayers:
                            _minimumPlayersFor(count),
                        onTap: () {
                          _selectCount(count);
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 14),

              _GlassCard(
                radius: 22,
                onTap: _done,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                  ),
                  child: const Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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

class _CountCard extends StatelessWidget {
  const _CountCard({
    required this.count,
    required this.selected,
    required this.available,
    required this.randomEnabled,
    required this.minimumPlayers,
    required this.onTap,
  });

  final int count;
  final bool selected;
  final bool available;
  final bool randomEnabled;
  final int minimumPlayers;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = randomEnabled
        ? 'Up to $count ${count == 1 ? 'impostor' : 'impostors'}'
        : '$count ${count == 1 ? 'impostor' : 'impostors'}';

    final subtitle = available
        ? randomEnabled
            ? count == 1
                ? '0 or 1 impostor'
                : '0 to $count impostors'
            : 'Exactly $count ${count == 1 ? 'impostor' : 'impostors'}'
        : 'Requires $minimumPlayers players';

    return _GlassCard(
      radius: 22,
      onTap: available ? onTap : () {},
      enabled: available,
      selected: selected,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        leading: AnimatedSwitcher(
          duration: const Duration(
            milliseconds: 220,
          ),
          child: !available
              ? const Icon(
                  Icons.lock_rounded,
                  key: ValueKey('locked'),
                  color: Colors.white24,
                  size: 28,
                )
              : selected
                  ? const Icon(
                      Icons.check_circle_rounded,
                      key: ValueKey('selected'),
                      color: Colors.white,
                      size: 30,
                    )
                  : const Icon(
                      Icons.radio_button_unchecked_rounded,
                      key: ValueKey('unselected'),
                      color: Colors.white54,
                      size: 30,
                    ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: available
                ? Colors.white
                : Colors.white30,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: available
                ? Colors.white54
                : Colors.white24,
          ),
        ),
        trailing: available && selected
            ? const Icon(
                Icons.done_rounded,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.radius,
    required this.child,
    this.onTap,
    this.enabled = true,
    this.selected = false,
  });

  final double radius;
  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: enabled ? onTap : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(radius),
            color: selected
                ? Colors.white.withValues(
                    alpha: 0.14,
                  )
                : Colors.white.withValues(
                    alpha: enabled ? 0.08 : 0.035,
                  ),
            border: Border.all(
              color: selected
                  ? Colors.white.withValues(
                      alpha: 0.28,
                    )
                  : Colors.white.withValues(
                      alpha: enabled ? 0.12 : 0.05,
                    ),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class ImpostorCountSelection {
  const ImpostorCountSelection({
    required this.count,
    required this.randomEnabled,
  });

  final int count;
  final bool randomEnabled;
}