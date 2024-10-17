import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/rank/bloc.dart';
import 'package:tft_guide/domain/models/rank/rank.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/ranked/body/button.dart';
import 'package:tft_guide/ui/pages/ranked/body/lp.dart';
import 'package:tft_guide/ui/pages/ranked/body/rank_asset.dart';
import 'package:tft_guide/ui/pages/ranked/body/rank_name.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

class RankedBody extends StatelessWidget {
  const RankedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          RankCubit()..compute(context.read<HydratedEloCubit>().state),
      child: BlocListener<HydratedEloCubit, int>(
        listener: _onEloChanged,
        child: BlocBuilder<RankCubit, RankState>(
          builder: (context, state) => switch (state) {
            RankLoadInProgress() => const SizedBox(
                height: 350,
                child: LoadingIndicator(),
              ),
            RankLoadOnSuccess(:final rank, :final lp) => _Content(
                rank: rank,
                lp: lp,
              ),
          },
        ),
      ),
    );
  }

  void _onEloChanged(BuildContext context, int elo) =>
      context.read<RankCubit>().compute(elo);
}

class _Content extends StatelessWidget {
  const _Content({
    required this.rank,
    required this.lp,
  });

  final Rank rank;
  final int lp;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: Sizes.cardPadding,
        child: Column(
          children: [
            RankedRankAsset(asset: rank.asset),
            RankedRankName(
              tier: rank.tier,
              division: rank.division,
            ),
            const SizedBox(height: 10),
            RankedLp(lp: lp),
            const SizedBox(height: 10),
            const StartGameButton(),
          ],
        ),
      ),
    );
  }
}
