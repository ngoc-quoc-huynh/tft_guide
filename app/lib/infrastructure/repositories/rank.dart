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
      < 100 => _iron4,
      < 200 => _iron3,
      < 300 => _iron2,
      < 400 => _iron1,
      < 500 => _bronze4,
      < 600 => _bronze3,
      < 700 => _bronze2,
      < 800 => _bronze1,
      < 900 => _silver4,
      < 1000 => _silver3,
      < 1100 => _silver2,
      < 1200 => _silver1,
      < 1300 => _gold4,
      < 1400 => _gold3,
      < 1500 => _gold2,
      < 1600 => _gold1,
      < 1700 => _platinum4,
      < 1800 => _platinum3,
      < 1900 => _platinum2,
      < 2000 => _platinum1,
      < 2100 => _emerald4,
      < 2200 => _emerald3,
      < 2300 => _emerald2,
      < 2400 => _emerald1,
      < 2500 => _diamond4,
      < 2600 => _diamond3,
      < 2700 => _diamond2,
      < 2800 => _diamond1,
      < 2900 => _master4,
      < 3000 => _master3,
      < 3100 => _master2,
      < 3200 => _master1,
      < 3300 => _grandmaster4,
      < 3400 => _grandmaster3,
      < 3500 => _grandmaster2,
      < 3600 => _grandmaster1,
      < 3700 => _challenger4,
      < 3800 => _challenger3,
      < 3900 => _challenger2,
      _ => _challenger1,
    };
  }

  static final _iron1 = Rank(
    tier: Tier.iron,
    division: Division.one,
    asset: Assets.iron1,
  );
  static final _iron2 = Rank(
    tier: Tier.iron,
    division: Division.two,
    asset: Assets.iron2,
  );
  static final _iron3 = Rank(
    tier: Tier.iron,
    division: Division.three,
    asset: Assets.iron3,
  );
  static final _iron4 = Rank(
    tier: Tier.iron,
    division: Division.four,
    asset: Assets.iron4,
  );

  static final _bronze1 = Rank(
    tier: Tier.bronze,
    division: Division.one,
    asset: Assets.bronze1,
  );
  static final _bronze2 = Rank(
    tier: Tier.bronze,
    division: Division.two,
    asset: Assets.bronze2,
  );
  static final _bronze3 = Rank(
    tier: Tier.bronze,
    division: Division.three,
    asset: Assets.bronze3,
  );
  static final _bronze4 = Rank(
    tier: Tier.bronze,
    division: Division.four,
    asset: Assets.bronze4,
  );

  static final _silver1 = Rank(
    tier: Tier.silver,
    division: Division.one,
    asset: Assets.silver1,
  );
  static final _silver2 = Rank(
    tier: Tier.silver,
    division: Division.two,
    asset: Assets.silver2,
  );
  static final _silver3 = Rank(
    tier: Tier.silver,
    division: Division.three,
    asset: Assets.silver3,
  );
  static final _silver4 = Rank(
    tier: Tier.silver,
    division: Division.four,
    asset: Assets.silver4,
  );

  static final _gold1 = Rank(
    tier: Tier.gold,
    division: Division.one,
    asset: Assets.gold1,
  );
  static final _gold2 = Rank(
    tier: Tier.gold,
    division: Division.two,
    asset: Assets.gold2,
  );
  static final _gold3 = Rank(
    tier: Tier.gold,
    division: Division.three,
    asset: Assets.gold3,
  );
  static final _gold4 = Rank(
    tier: Tier.gold,
    division: Division.four,
    asset: Assets.gold4,
  );

  static final _platinum1 = Rank(
    tier: Tier.platinum,
    division: Division.one,
    asset: Assets.platinum1,
  );
  static final _platinum2 = Rank(
    tier: Tier.platinum,
    division: Division.two,
    asset: Assets.platinum2,
  );
  static final _platinum3 = Rank(
    tier: Tier.platinum,
    division: Division.three,
    asset: Assets.platinum3,
  );
  static final _platinum4 = Rank(
    tier: Tier.platinum,
    division: Division.four,
    asset: Assets.platinum4,
  );

  static final _emerald1 = Rank(
    tier: Tier.emerald,
    division: Division.one,
    asset: Assets.emerald1,
  );
  static final _emerald2 = Rank(
    tier: Tier.emerald,
    division: Division.two,
    asset: Assets.emerald2,
  );
  static final _emerald3 = Rank(
    tier: Tier.emerald,
    division: Division.three,
    asset: Assets.emerald3,
  );
  static final _emerald4 = Rank(
    tier: Tier.emerald,
    division: Division.four,
    asset: Assets.emerald4,
  );

  static final _diamond1 = Rank(
    tier: Tier.diamond,
    division: Division.one,
    asset: Assets.diamond1,
  );
  static final _diamond2 = Rank(
    tier: Tier.diamond,
    division: Division.two,
    asset: Assets.diamond2,
  );
  static final _diamond3 = Rank(
    tier: Tier.diamond,
    division: Division.three,
    asset: Assets.diamond3,
  );
  static final _diamond4 = Rank(
    tier: Tier.diamond,
    division: Division.four,
    asset: Assets.diamond4,
  );

  static final _master1 = Rank(
    tier: Tier.master,
    division: Division.one,
    asset: Assets.master1,
  );
  static final _master2 = Rank(
    tier: Tier.master,
    division: Division.two,
    asset: Assets.master2,
  );
  static final _master3 = Rank(
    tier: Tier.master,
    division: Division.three,
    asset: Assets.master3,
  );
  static final _master4 = Rank(
    tier: Tier.master,
    division: Division.four,
    asset: Assets.master4,
  );

  static final _grandmaster1 = Rank(
    tier: Tier.grandmaster,
    division: Division.one,
    asset: Assets.grandmaster1,
  );
  static final _grandmaster2 = Rank(
    tier: Tier.grandmaster,
    division: Division.two,
    asset: Assets.grandmaster2,
  );
  static final _grandmaster3 = Rank(
    tier: Tier.grandmaster,
    division: Division.three,
    asset: Assets.grandmaster3,
  );
  static final _grandmaster4 = Rank(
    tier: Tier.grandmaster,
    division: Division.four,
    asset: Assets.grandmaster4,
  );

  static final _challenger1 = Rank(
    tier: Tier.challenger,
    division: Division.one,
    asset: Assets.challenger1,
  );
  static final _challenger2 = Rank(
    tier: Tier.challenger,
    division: Division.two,
    asset: Assets.challenger2,
  );
  static final _challenger3 = Rank(
    tier: Tier.challenger,
    division: Division.three,
    asset: Assets.challenger3,
  );
  static final _challenger4 = Rank(
    tier: Tier.challenger,
    division: Division.four,
    asset: Assets.challenger4,
  );
}
