import 'package:collection/collection.dart';

/// Band score calculator.
class ScoreCalculationService {
  /// Calculates average score of given scores based on IELTS round rule.
  static double calculateScore(List<double> scores) {
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
