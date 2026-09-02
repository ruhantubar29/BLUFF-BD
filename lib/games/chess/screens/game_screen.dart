import 'package:flutter/material.dart';

import '../logic/chess_logic.dart';
import '../widgets/chess_board.dart';

class ChessGameScreen extends StatefulWidget {
  const ChessGameScreen({super.key});

  @override
  State<ChessGameScreen> createState() => _ChessGameScreenState();
}

class _ChessGameScreenState extends State<ChessGameScreen> {
  late List<List<String>> board;

  int? selectedRow;
  int? selectedCol;

  bool whiteTurn = true;

  @override
  void initState() {
    super.initState();
    board = ChessLogic.createInitialBoard();
  }

  void onSquareTap(int row, int col) {
    final piece = board[row][col];

    // Nothing selected yet.
    if (selectedRow == null) {
      if (piece.isEmpty) return;

      if (!_isCorrectTurn(piece)) return;

      setState(() {
        selectedRow = row;
        selectedCol = col;
      });

      return;
    }

    // Tapping the selected piece again cancels selection.
    if (selectedRow == row && selectedCol == col) {
      setState(() {
        selectedRow = null;
        selectedCol = null;
      });

      return;
    }

    // Select another piece belonging to the current player.
    if (piece.isNotEmpty && _isCorrectTurn(piece)) {
      setState(() {
        selectedRow = row;
        selectedCol = col;
      });

      return;
    }

    // Move the selected piece.
    setState(() {
      board[row][col] = board[selectedRow!][selectedCol!];
      board[selectedRow!][selectedCol!] = '';

      selectedRow = null;
      selectedCol = null;

      whiteTurn = !whiteTurn;
    });
  }

  bool _isCorrectTurn(String piece) {
    final isWhite = _isWhitePiece(piece);

    return isWhite == whiteTurn;
  }

  bool _isWhitePiece(String piece) {
    return '♙♖♘♗♕♔'.contains(piece);
  }

  void restartGame() {
    setState(() {
      board = ChessLogic.createInitialBoard();

      selectedRow = null;
      selectedCol = null;

      whiteTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chess',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Text(
              whiteTurn ? "White's turn" : "Black's turn",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ChessBoard(
              board: board,
              selectedRow: selectedRow,
              selectedCol: selectedCol,
              onSquareTap: onSquareTap,
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: restartGame,
                  child: const Text(
                    'RESTART',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}