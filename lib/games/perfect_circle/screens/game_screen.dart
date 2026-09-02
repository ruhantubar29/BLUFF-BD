import 'package:flutter/material.dart';

import '../logic/circle_score.dart';
import '../widgets/drawing_area.dart';

class PerfectCircleGameScreen extends StatefulWidget {
  const PerfectCircleGameScreen({super.key});

  @override
  State<PerfectCircleGameScreen> createState() =>
      _PerfectCircleGameScreenState();
}

class _PerfectCircleGameScreenState
    extends State<PerfectCircleGameScreen> {
  double? score;
  bool hasDrawn = false;

  void drawingFinished(List<Offset> points) {
    final result = CircleScore.calculate(points);

    setState(() {
      score = result;
      hasDrawn = true;
    });
  }

  void tryAgain() {
    setState(() {
      score = null;
      hasDrawn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfect Circle',
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
                'Draw a perfect circle',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Start anywhere and draw without lifting your finger.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: DrawingArea(
                    onDrawingFinished: drawingFinished,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (hasDrawn && score != null) ...[
                Text(
                  '${score!.round()}%',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  _getMessage(score!),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: tryAgain,
                    child: const Text(
                      'TRY AGAIN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ] else
                const SizedBox(height: 55),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String _getMessage(double score) {
    if (score >= 95) {
      return 'PERFECT! 🔥';
    }

    if (score >= 85) {
      return 'Excellent!';
    }

    if (score >= 70) {
      return 'Pretty good!';
    }

    if (score >= 50) {
      return 'Not bad!';
    }

    return 'Try again!';
  }
}