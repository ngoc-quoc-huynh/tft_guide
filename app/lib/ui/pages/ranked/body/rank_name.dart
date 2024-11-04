import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';
import 'package:tft_guide/injector.dart';

class RankedRankName extends StatelessWidget {
  const RankedRankName({
    required this.tier,
    required this.division,
    super.key,
  });

  final Tier tier;
  final Division division;

  @override
  Widget build(BuildContext context) {
    return Text(
      _tier(division: division.name),
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  String Function({required String division}) get _tier => switch (tier) {
        Tier.iron => _tiersTranslation.iron,
        Tier.bronze => _tiersTranslation.bronze,
        Tier.silver => _tiersTranslation.silver,
        Tier.gold => _tiersTranslation.gold,
        Tier.platinum => _tiersTranslation.platinum,
        Tier.emerald => _tiersTranslation.emerald,
        Tier.diamond => _tiersTranslation.diamond,
        Tier.master => _tiersTranslation.master,
        Tier.grandmaster => _tiersTranslation.grandmaster,
        Tier.challenger => _tiersTranslation.challenger,
      };

  static TranslationsPagesRankedEn get _translations =>
      Injector.instance.translations.pages.ranked;

  static TranslationsPagesRankedTiersEn get _tiersTranslation =>
      _translations.tiers;
}
