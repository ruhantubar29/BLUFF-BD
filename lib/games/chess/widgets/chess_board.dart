import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  final List<List<String>> board;
  final int? selectedRow;
  final int? selectedCol;
  final Function(int row, int col) onSquareTap;

  const ChessBoard({
    super.key,
    required this.board,
    required this.selectedRow,
    required this.selectedCol,
    required this.onSquareTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemCount: 64,
        itemBuilder: (context, index) {
          final row = index ~/ 8;
          final col = index % 8;

          final isLight = (row + col).isEven;

          final isSelected =
              selectedRow == row && selectedCol == col;

          return GestureDetector(
            onTap: () => onSquareTap(row, col),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.amber
                    : isLight
                        ? const Color(0xFFF0D9B5)
                        : const Color(0xFFB58863),
              ),
              child: Center(
                child: Text(
                  board[row][col],
                  style: const TextStyle(
                    fontSize: 36,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}