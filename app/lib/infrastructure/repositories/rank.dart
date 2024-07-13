import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/models/rank.dart';

final class LocalRankRepository implements RankRepository {
  const LocalRankRepository();

  static const _promotionPoints = 100;

  @override
  Rank computeRank(int elo) => Rank(
        tier: _computeTier(elo),
        division: _computeDivision(elo),
        lp: _computeLp(elo),
      );

  Tier _computeTier(int elo) {
    final tierIndex = (elo / (Division.values.length * _promotionPoints))
        .floor()
        .clamp(0, Tier.values.length - 1);
    return Tier.values[tierIndex];
  }

  static final _challengerOnePoints =
      Tier.values.length * Division.values.length * _promotionPoints -
          _promotionPoints;

  Division _computeDivision(int elo) {
    final divisionLength = Division.values.length;
    final divisionIndex = switch (elo < _challengerOnePoints) {
      false => divisionLength - 1,
      true => elo % (divisionLength * _promotionPoints) ~/ _promotionPoints,
    };
    return Division.values.reversed.toList()[divisionIndex];
  }

  int _computeLp(int elo) {
    return switch (elo < _challengerOnePoints) {
      false => elo - _challengerOnePoints,
      true => elo % _promotionPoints,
    };
  }
}
