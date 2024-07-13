import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/domain/blocs/elo/cubit.dart';
import 'package:tft_guide/domain/blocs/rank/cubit.dart';
import 'package:tft_guide/domain/models/rank.dart';
import 'package:tft_guide/static/resources/assets.dart';

class RankAsset extends StatelessWidget {
  const RankAsset({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EloCubit, int>(
      listener: (context, elo) => context.read<RankCubit>().compute(elo),
      child: BlocSelector<RankCubit, Rank?, bool>(
        selector: (state) => state == null,
        builder: (context, isLoading) => switch (isLoading) {
          true => const Skeletonizer(
              child: Bone(
                height: 250,
                width: 215,
              ),
            ),
          false => BlocSelector<RankCubit, Rank?, (Tier, Division)>(
              selector: (state) => (state!.tier, state.division),
              builder: (context, state) => Image.asset(
                _computeAsset(
                  tier: state.$1,
                  division: state.$2,
                ).path,
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
        },
      ),
    );
  }

  Asset _computeAsset({required Tier tier, required Division division}) =>
      switch (tier) {
        Tier.iron when division == Division.one => Assets.iron1,
        Tier.iron when division == Division.two => Assets.iron2,
        Tier.iron when division == Division.three => Assets.iron3,
        Tier.iron => Assets.iron4,
        Tier.bronze when division == Division.one => Assets.bronze1,
        Tier.bronze when division == Division.two => Assets.bronze2,
        Tier.bronze when division == Division.three => Assets.bronze3,
        Tier.bronze => Assets.bronze4,
        Tier.silver when division == Division.one => Assets.silver1,
        Tier.silver when division == Division.two => Assets.silver2,
        Tier.silver when division == Division.three => Assets.silver3,
        Tier.silver => Assets.silver4,
        Tier.gold when division == Division.one => Assets.gold1,
        Tier.gold when division == Division.two => Assets.gold2,
        Tier.gold when division == Division.three => Assets.gold3,
        Tier.gold => Assets.gold4,
        Tier.platinum when division == Division.one => Assets.platinum1,
        Tier.platinum when division == Division.two => Assets.platinum2,
        Tier.platinum when division == Division.three => Assets.platinum3,
        Tier.platinum => Assets.platinum4,
        Tier.emerald when division == Division.one => Assets.emerald1,
        Tier.emerald when division == Division.two => Assets.emerald2,
        Tier.emerald when division == Division.three => Assets.emerald3,
        Tier.emerald => Assets.emerald4,
        Tier.diamond when division == Division.one => Assets.diamond1,
        Tier.diamond when division == Division.two => Assets.diamond2,
        Tier.diamond when division == Division.three => Assets.diamond3,
        Tier.diamond => Assets.diamond4,
        Tier.master when division == Division.one => Assets.master1,
        Tier.master when division == Division.two => Assets.master2,
        Tier.master when division == Division.three => Assets.master3,
        Tier.master => Assets.master4,
        Tier.grandmaster when division == Division.one => Assets.grandmaster1,
        Tier.grandmaster when division == Division.two => Assets.grandmaster2,
        Tier.grandmaster when division == Division.three => Assets.grandmaster3,
        Tier.grandmaster => Assets.grandmaster4,
        Tier.challenger when division == Division.one => Assets.challenger1,
        Tier.challenger when division == Division.two => Assets.challenger2,
        Tier.challenger when division == Division.three => Assets.challenger3,
        Tier.challenger => Assets.challenger4,
      };
}
