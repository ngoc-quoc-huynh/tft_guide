import 'package:flutter/foundation.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/rank.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';
import 'package:tft_guide/static/resources/assets.dart';

@immutable
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
      < 100 => iron4,
      < 200 => iron3,
      < 300 => iron2,
      < 400 => iron1,
      < 500 => bronze4,
      < 600 => bronze3,
      < 700 => bronze2,
      < 800 => bronze1,
      < 900 => silver4,
      < 1000 => silver3,
      < 1100 => silver2,
      < 1200 => silver1,
      < 1300 => gold4,
      < 1400 => gold3,
      < 1500 => gold2,
      < 1600 => gold1,
      < 1700 => platinum4,
      < 1800 => platinum3,
      < 1900 => platinum2,
      < 2000 => platinum1,
      < 2100 => emerald4,
      < 2200 => emerald3,
      < 2300 => emerald2,
      < 2400 => emerald1,
      < 2500 => diamond4,
      < 2600 => diamond3,
      < 2700 => diamond2,
      < 2800 => diamond1,
      < 2900 => master4,
      < 3000 => master3,
      < 3100 => master2,
      < 3200 => master1,
      < 3300 => grandmaster4,
      < 3400 => grandmaster3,
      < 3500 => grandmaster2,
      < 3600 => grandmaster1,
      < 3700 => challenger4,
      < 3800 => challenger3,
      < 3900 => challenger2,
      _ => challenger1,
    };
  }

  @visibleForTesting
  static final iron1 = Rank(
    tier: Tier.iron,
    division: Division.one,
    asset: Assets.iron1,
  );
  @visibleForTesting
  static final iron2 = Rank(
    tier: Tier.iron,
    division: Division.two,
    asset: Assets.iron2,
  );
  @visibleForTesting
  static final iron3 = Rank(
    tier: Tier.iron,
    division: Division.three,
    asset: Assets.iron3,
  );
  @visibleForTesting
  static final iron4 = Rank(
    tier: Tier.iron,
    division: Division.four,
    asset: Assets.iron4,
  );
  @visibleForTesting
  static final bronze1 = Rank(
    tier: Tier.bronze,
    division: Division.one,
    asset: Assets.bronze1,
  );
  @visibleForTesting
  static final bronze2 = Rank(
    tier: Tier.bronze,
    division: Division.two,
    asset: Assets.bronze2,
  );
  @visibleForTesting
  static final bronze3 = Rank(
    tier: Tier.bronze,
    division: Division.three,
    asset: Assets.bronze3,
  );
  @visibleForTesting
  static final bronze4 = Rank(
    tier: Tier.bronze,
    division: Division.four,
    asset: Assets.bronze4,
  );

  @visibleForTesting
  static final silver1 = Rank(
    tier: Tier.silver,
    division: Division.one,
    asset: Assets.silver1,
  );
  @visibleForTesting
  static final silver2 = Rank(
    tier: Tier.silver,
    division: Division.two,
    asset: Assets.silver2,
  );
  @visibleForTesting
  static final silver3 = Rank(
    tier: Tier.silver,
    division: Division.three,
    asset: Assets.silver3,
  );
  @visibleForTesting
  static final silver4 = Rank(
    tier: Tier.silver,
    division: Division.four,
    asset: Assets.silver4,
  );
  @visibleForTesting
  static final gold1 = Rank(
    tier: Tier.gold,
    division: Division.one,
    asset: Assets.gold1,
  );
  @visibleForTesting
  static final gold2 = Rank(
    tier: Tier.gold,
    division: Division.two,
    asset: Assets.gold2,
  );
  @visibleForTesting
  static final gold3 = Rank(
    tier: Tier.gold,
    division: Division.three,
    asset: Assets.gold3,
  );
  @visibleForTesting
  static final gold4 = Rank(
    tier: Tier.gold,
    division: Division.four,
    asset: Assets.gold4,
  );
  @visibleForTesting
  static final platinum1 = Rank(
    tier: Tier.platinum,
    division: Division.one,
    asset: Assets.platinum1,
  );
  @visibleForTesting
  static final platinum2 = Rank(
    tier: Tier.platinum,
    division: Division.two,
    asset: Assets.platinum2,
  );
  @visibleForTesting
  static final platinum3 = Rank(
    tier: Tier.platinum,
    division: Division.three,
    asset: Assets.platinum3,
  );
  @visibleForTesting
  static final platinum4 = Rank(
    tier: Tier.platinum,
    division: Division.four,
    asset: Assets.platinum4,
  );
  @visibleForTesting
  static final emerald1 = Rank(
    tier: Tier.emerald,
    division: Division.one,
    asset: Assets.emerald1,
  );
  @visibleForTesting
  static final emerald2 = Rank(
    tier: Tier.emerald,
    division: Division.two,
    asset: Assets.emerald2,
  );
  @visibleForTesting
  static final emerald3 = Rank(
    tier: Tier.emerald,
    division: Division.three,
    asset: Assets.emerald3,
  );
  @visibleForTesting
  static final emerald4 = Rank(
    tier: Tier.emerald,
    division: Division.four,
    asset: Assets.emerald4,
  );
  @visibleForTesting
  static final diamond1 = Rank(
    tier: Tier.diamond,
    division: Division.one,
    asset: Assets.diamond1,
  );
  @visibleForTesting
  static final diamond2 = Rank(
    tier: Tier.diamond,
    division: Division.two,
    asset: Assets.diamond2,
  );
  @visibleForTesting
  static final diamond3 = Rank(
    tier: Tier.diamond,
    division: Division.three,
    asset: Assets.diamond3,
  );
  @visibleForTesting
  static final diamond4 = Rank(
    tier: Tier.diamond,
    division: Division.four,
    asset: Assets.diamond4,
  );
  @visibleForTesting
  static final master1 = Rank(
    tier: Tier.master,
    division: Division.one,
    asset: Assets.master1,
  );
  @visibleForTesting
  static final master2 = Rank(
    tier: Tier.master,
    division: Division.two,
    asset: Assets.master2,
  );
  @visibleForTesting
  static final master3 = Rank(
    tier: Tier.master,
    division: Division.three,
    asset: Assets.master3,
  );
  @visibleForTesting
  static final master4 = Rank(
    tier: Tier.master,
    division: Division.four,
    asset: Assets.master4,
  );
  @visibleForTesting
  static final grandmaster1 = Rank(
    tier: Tier.grandmaster,
    division: Division.one,
    asset: Assets.grandmaster1,
  );
  @visibleForTesting
  static final grandmaster2 = Rank(
    tier: Tier.grandmaster,
    division: Division.two,
    asset: Assets.grandmaster2,
  );
  @visibleForTesting
  static final grandmaster3 = Rank(
    tier: Tier.grandmaster,
    division: Division.three,
    asset: Assets.grandmaster3,
  );
  @visibleForTesting
  static final grandmaster4 = Rank(
    tier: Tier.grandmaster,
    division: Division.four,
    asset: Assets.grandmaster4,
  );

  @visibleForTesting
  static final challenger1 = Rank(
    tier: Tier.challenger,
    division: Division.one,
    asset: Assets.challenger1,
  );
  @visibleForTesting
  static final challenger2 = Rank(
    tier: Tier.challenger,
    division: Division.two,
    asset: Assets.challenger2,
  );
  @visibleForTesting
  static final challenger3 = Rank(
    tier: Tier.challenger,
    division: Division.three,
    asset: Assets.challenger3,
  );
  @visibleForTesting
  static final challenger4 = Rank(
    tier: Tier.challenger,
    division: Division.four,
    asset: Assets.challenger4,
  );
}
