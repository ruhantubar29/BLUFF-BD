import 'dart:math';
import 'package:flutter/material.dart';

class CircleScore {
  static double calculate(List<Offset> points) {
    if (points.length < 10) {
      return 0;
    }

    // Calculate the average point.
    double centerX = 0;
    double centerY = 0;

    for (final point in points) {
      centerX += point.dx;
      centerY += point.dy;
    }

    centerX /= points.length;
    centerY /= points.length;

    final center = Offset(centerX, centerY);

    // Calculate the distance of every point
    // from the estimated center.
    final distances = points.map((point) {
      return (point - center).distance;
    }).toList();

    final averageRadius =
        distances.reduce((a, b) => a + b) /
            distances.length;

    if (averageRadius == 0) {
      return 0;
    }

    // Measure how much the radius changes.
    double error = 0;

    for (final distance in distances) {
      error +=
          (distance - averageRadius).abs();
    }

    error /= distances.length;

    final errorRatio =
        error / averageRadius;

    // Convert error into a score.
    double score =
        100 - (errorRatio * 200);

    // Check whether the player
    // actually closed the circle.
    final closingDistance =
        (points.first - points.last).distance;

    final closingRatio =
        closingDistance / averageRadius;

    score -= closingRatio * 20;

    score = score.clamp(0, 100);

    return score;
  }
}