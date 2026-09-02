import 'package:flutter/material.dart';

import '../models/impostor_player.dart';
import '../models/impostor_settings.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    super.key,
    required this.players,
  });

  final List<ImpostorPlayer> players;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late List<ImpostorPlayer> _players;

  int? _editingIndex;

  final TextEditingController _controller =
      TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _players = widget.players
        .map(
          (player) => player.copyWith(),
        )
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // --------------------------------------------------
  // START EDITING
  // --------------------------------------------------

  void _startEditing(int index) {
    if (_editingIndex != null) {
      _finishEditing();
    }

    setState(() {
      _editingIndex = index;
      _controller.text = _players[index].name;
    });

    Future.delayed(
      const Duration(milliseconds: 60),
      () {
        if (!mounted) {
          return;
        }

        _focusNode.requestFocus();

        _controller.selection =
            TextSelection.fromPosition(
          TextPosition(
            offset: _controller.text.length,
          ),
        );
      },
    );
  }

  // --------------------------------------------------
  // FINISH EDITING
  // --------------------------------------------------

  void _finishEditing() {
    if (_editingIndex != null) {
      final index = _editingIndex!;

      final name = _controller.text.trim();

      setState(() {
        _players[index] = _players[index].copyWith(
          name: name.isEmpty
              ? 'Player ${index + 1}'
              : name,
        );

        _editingIndex = null;
      });
    }
  }

  // --------------------------------------------------
  // ADD PLAYER
  // --------------------------------------------------

  void _addPlayer() {
    if (_players.length >=
        ImpostorSettings.maxPlayers) {
      return;
    }

    setState(() {
      _players.add(
        ImpostorPlayer(
          name: 'Player ${_players.length + 1}',
        ),
      );
    });
  }

  // --------------------------------------------------
  // REMOVE PLAYER
  // --------------------------------------------------

  void _removePlayer(int index) {
    if (_players.length <=
        ImpostorSettings.minPlayers) {
      return;
    }

    setState(() {
      _players.removeAt(index);

      if (_editingIndex == index) {
        _editingIndex = null;
      } else if (_editingIndex != null &&
          _editingIndex! > index) {
        _editingIndex = _editingIndex! - 1;
      }
    });
  }

  // --------------------------------------------------
  // DONE
  // --------------------------------------------------

  void _done() {
    _finishEditing();

    Navigator.pop(
      context,
      _players,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final canAdd =
        _players.length <
            ImpostorSettings.maxPlayers;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Players'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // --------------------------------------------------
            // PLAYER COUNT
            // --------------------------------------------------

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                12,
                20,
                8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${_players.length} Players',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${ImpostorSettings.minPlayers}'
                    '–'
                    '${ImpostorSettings.maxPlayers}',
                    style:
                        theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // --------------------------------------------------
            // PLAYER LIST
            // --------------------------------------------------

            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  10,
                ),
                itemCount: _players.length,
                itemBuilder:
                    (context, index) {
                  final player =
                      _players[index];

                  final isEditing =
                      _editingIndex == index;

                  return Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Card(
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),

                        // PLAYER NUMBER
                        leading: CircleAvatar(
                          child: Text(
                            '${index + 1}',
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),

                        // PLAYER NAME
                        title: isEditing
                            ? TextField(
                                controller:
                                    _controller,
                                focusNode:
                                    _focusNode,
                                autofocus:
                                    true,
                                textInputAction:
                                    TextInputAction
                                        .done,
                                style:
                                    const TextStyle(
                                  fontSize: 18,
                                ),
                                decoration:
                                    const InputDecoration(
                                  border:
                                      InputBorder.none,
                                  hintText:
                                      'Player name',
                                ),
                                onSubmitted:
                                    (_) {
                                  _finishEditing();
                                },
                              )
                            : Text(
                                player.name,
                                style:
                                    const TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),

                        // DELETE
                        trailing: _players.length >
                                ImpostorSettings
                                    .minPlayers
                            ? IconButton(
                                onPressed:
                                    () {
                                  _removePlayer(
                                    index,
                                  );
                                },
                                icon:
                                    const Icon(
                                  Icons
                                      .delete_outline_rounded,
                                ),
                              )
                            : null,

                        onTap: () {
                          _startEditing(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),

            // --------------------------------------------------
            // BOTTOM BUTTONS
            // --------------------------------------------------

            Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                8,
                20,
                20,
              ),
              child: Column(
                children: [
                  // ADD PLAYER
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed:
                          canAdd
                              ? _addPlayer
                              : null,
                      icon: const Icon(
                        Icons
                            .add_circle_outline_rounded,
                      ),
                      label: const Text(
                        'Add Player',
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // DONE
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: FilledButton(
                      onPressed: _done,
                      child: const Text(
                        'DONE',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}