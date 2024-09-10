import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/rank.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';

final class LocalRankRepository implements RankApi {
  const LocalRankRepository();

  static const _promotionPoints = 100;
  static final _challengerOneElo =
      Tier.values.length * Division.values.length * _promotionPoints -
          _promotionPoints;

  @override
  int computeLp(int elo) => switch (elo < _challengerOneElo) {
        false => elo - _challengerOneElo,
        true => elo % _promotionPoints,
      };

  @override
  Rank computeRank(int elo) {
    assert(elo >= 0, 'Elo must be a positive number.');
    return switch (elo) {
      < 100 => Ranks.iron4,
      < 200 => Ranks.iron3,
      < 300 => Ranks.iron2,
      < 400 => Ranks.iron1,
      < 500 => Ranks.silver4,
      < 600 => Ranks.silver3,
      < 700 => Ranks.silver2,
      < 800 => Ranks.silver1,
      < 900 => Ranks.gold4,
      < 1000 => Ranks.gold3,
      < 1100 => Ranks.gold2,
      < 1200 => Ranks.gold1,
      < 1300 => Ranks.platinum4,
      < 1400 => Ranks.platinum3,
      < 1500 => Ranks.platinum2,
      < 1600 => Ranks.platinum1,
      < 1700 => Ranks.emerald4,
      < 1800 => Ranks.emerald3,
      < 1900 => Ranks.emerald2,
      < 2000 => Ranks.emerald1,
      < 2100 => Ranks.diamond4,
      < 2200 => Ranks.diamond3,
      < 2300 => Ranks.diamond2,
      < 2400 => Ranks.diamond1,
      < 2500 => Ranks.master4,
      < 2600 => Ranks.master3,
      < 2700 => Ranks.master2,
      < 2800 => Ranks.master1,
      < 2900 => Ranks.grandmaster4,
      < 3000 => Ranks.grandmaster3,
      < 3100 => Ranks.grandmaster2,
      < 3200 => Ranks.grandmaster1,
      < 3300 => Ranks.challenger4,
      < 3400 => Ranks.challenger3,
      < 3500 => Ranks.challenger2,
      _ => Ranks.challenger1,
    };
  }
}
