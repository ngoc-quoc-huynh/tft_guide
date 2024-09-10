import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/asset.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';
import 'package:tft_guide/static/resources/assets.dart';

final class Rank extends Equatable {
  const Rank({
    required this.tier,
    required this.division,
    required this.asset,
  });

  final Tier tier;
  final Division division;
  final Asset asset;

  @override
  List<Object?> get props => [
        tier,
        division,
        asset,
      ];
}

final class Ranks {
  const Ranks._();

  static final iron1 = Rank(
    tier: Tier.iron,
    division: Division.one,
    asset: Assets.iron1,
  );
  static final iron2 = Rank(
    tier: Tier.iron,
    division: Division.two,
    asset: Assets.iron2,
  );
  static final iron3 = Rank(
    tier: Tier.iron,
    division: Division.three,
    asset: Assets.iron3,
  );
  static final iron4 = Rank(
    tier: Tier.iron,
    division: Division.four,
    asset: Assets.iron4,
  );

  static final bronze1 = Rank(
    tier: Tier.bronze,
    division: Division.one,
    asset: Assets.bronze1,
  );
  static final bronze2 = Rank(
    tier: Tier.bronze,
    division: Division.two,
    asset: Assets.bronze2,
  );
  static final bronze3 = Rank(
    tier: Tier.bronze,
    division: Division.three,
    asset: Assets.bronze3,
  );
  static final bronze4 = Rank(
    tier: Tier.bronze,
    division: Division.four,
    asset: Assets.bronze4,
  );

  static final silver1 = Rank(
    tier: Tier.silver,
    division: Division.one,
    asset: Assets.silver1,
  );
  static final silver2 = Rank(
    tier: Tier.silver,
    division: Division.two,
    asset: Assets.silver2,
  );
  static final silver3 = Rank(
    tier: Tier.silver,
    division: Division.three,
    asset: Assets.silver3,
  );
  static final silver4 = Rank(
    tier: Tier.silver,
    division: Division.four,
    asset: Assets.silver4,
  );

  static final gold1 = Rank(
    tier: Tier.gold,
    division: Division.one,
    asset: Assets.gold1,
  );
  static final gold2 = Rank(
    tier: Tier.gold,
    division: Division.two,
    asset: Assets.gold2,
  );
  static final gold3 = Rank(
    tier: Tier.gold,
    division: Division.three,
    asset: Assets.gold3,
  );
  static final gold4 = Rank(
    tier: Tier.gold,
    division: Division.four,
    asset: Assets.gold4,
  );

  static final platinum1 = Rank(
    tier: Tier.platinum,
    division: Division.one,
    asset: Assets.platinum1,
  );
  static final platinum2 = Rank(
    tier: Tier.platinum,
    division: Division.two,
    asset: Assets.platinum2,
  );
  static final platinum3 = Rank(
    tier: Tier.platinum,
    division: Division.three,
    asset: Assets.platinum3,
  );
  static final platinum4 = Rank(
    tier: Tier.platinum,
    division: Division.four,
    asset: Assets.platinum4,
  );

  static final emerald1 = Rank(
    tier: Tier.emerald,
    division: Division.one,
    asset: Assets.emerald1,
  );
  static final emerald2 = Rank(
    tier: Tier.emerald,
    division: Division.two,
    asset: Assets.emerald2,
  );
  static final emerald3 = Rank(
    tier: Tier.emerald,
    division: Division.three,
    asset: Assets.emerald3,
  );
  static final emerald4 = Rank(
    tier: Tier.emerald,
    division: Division.four,
    asset: Assets.emerald4,
  );

  static final diamond1 = Rank(
    tier: Tier.diamond,
    division: Division.one,
    asset: Assets.diamond1,
  );
  static final diamond2 = Rank(
    tier: Tier.diamond,
    division: Division.two,
    asset: Assets.diamond2,
  );
  static final diamond3 = Rank(
    tier: Tier.diamond,
    division: Division.three,
    asset: Assets.diamond3,
  );
  static final diamond4 = Rank(
    tier: Tier.diamond,
    division: Division.four,
    asset: Assets.diamond4,
  );

  static final master1 = Rank(
    tier: Tier.master,
    division: Division.one,
    asset: Assets.master1,
  );
  static final master2 = Rank(
    tier: Tier.master,
    division: Division.two,
    asset: Assets.master2,
  );
  static final master3 = Rank(
    tier: Tier.master,
    division: Division.three,
    asset: Assets.master3,
  );
  static final master4 = Rank(
    tier: Tier.master,
    division: Division.four,
    asset: Assets.master4,
  );

  static final grandmaster1 = Rank(
    tier: Tier.grandmaster,
    division: Division.one,
    asset: Assets.grandmaster1,
  );
  static final grandmaster2 = Rank(
    tier: Tier.grandmaster,
    division: Division.two,
    asset: Assets.grandmaster2,
  );
  static final grandmaster3 = Rank(
    tier: Tier.grandmaster,
    division: Division.three,
    asset: Assets.grandmaster3,
  );
  static final grandmaster4 = Rank(
    tier: Tier.grandmaster,
    division: Division.four,
    asset: Assets.grandmaster4,
  );

  static final challenger1 = Rank(
    tier: Tier.challenger,
    division: Division.one,
    asset: Assets.challenger1,
  );
  static final challenger2 = Rank(
    tier: Tier.challenger,
    division: Division.two,
    asset: Assets.challenger2,
  );
  static final challenger3 = Rank(
    tier: Tier.challenger,
    division: Division.three,
    asset: Assets.challenger3,
  );
  static final challenger4 = Rank(
    tier: Tier.challenger,
    division: Division.four,
    asset: Assets.challenger4,
  );
}
