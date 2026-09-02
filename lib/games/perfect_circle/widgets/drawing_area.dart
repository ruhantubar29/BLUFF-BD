import 'package:flutter/material.dart';

class DrawingArea extends StatefulWidget {
  final ValueChanged<List<Offset>> onDrawingFinished;

  const DrawingArea({
    super.key,
    required this.onDrawingFinished,
  });

  @override
  State<DrawingArea> createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  final List<Offset> points = [];

  bool isDrawing = false;

  void startDrawing(Offset position) {
    setState(() {
      points.clear();
      points.add(position);
      isDrawing = true;
    });
  }

  void updateDrawing(Offset position) {
    if (!isDrawing) return;

    setState(() {
      points.add(position);
    });
  }

  void finishDrawing() {
    if (!isDrawing) return;

    setState(() {
      isDrawing = false;
    });

    if (points.length > 10) {
      widget.onDrawingFinished(
        List<Offset>.from(points),
      );
    }
  }

  void clear() {
    setState(() {
      points.clear();
      isDrawing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        startDrawing(details.localPosition);
      },
      onPanUpdate: (details) {
        updateDrawing(details.localPosition);
      },
      onPanEnd: (_) {
        finishDrawing();
      },
      child: CustomPaint(
        painter: CirclePainter(points),
        size: Size.infinite,
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final List<Offset> points;

  CirclePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    final paint = Paint()
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(
      points.first.dx,
      points.first.dy,
    );

    for (int i = 1; i < points.length; i++) {
      path.lineTo(
        points[i].dx,
        points[i].dy,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}