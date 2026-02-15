import 'package:collection/collection.dart';

/// Band score calculator.
class ScoreCalculationService {
  /// Returns band score calculated with the given scores.
  static double calculateScore(List<double> scores) {
    if (scores.length < 3) {
      throw ArgumentError('Require more than two scores.');
    }
    final sum = scores.sum;
    final avg = sum / scores.length;
    var score = avg.truncateToDouble();

    double frac = avg - score;
    if (frac >= 0.75) {
      score += 1.0;
    } else if (frac >= 0.25) {
      score += 0.5;
    }

    return score;
  }
}
