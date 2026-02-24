import 'package:collection/collection.dart';

/// Band score calculator.
class ScoreCalculationService {
  /// Calculates average score of given scores based on IELTS round rule.
  static double calculateScore(List<double> scores) {
    final sum = scores.sum;
    final avg = sum / scores.length;
    return roundToNearest(avg);
  }

  /// Rounds to nearest 0.5.
  static double roundToNearest(double score) {
    var rounded = score.truncateToDouble();

    double frac = score - rounded;
    if (frac >= 0.75) {
      rounded += 1.0;
    } else if (frac >= 0.25) {
      rounded += 0.5;
    }

    return rounded;
  }
}
