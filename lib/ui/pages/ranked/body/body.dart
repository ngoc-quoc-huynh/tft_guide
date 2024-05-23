import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/elo/cubit.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/domain/blocs/rank/cubit.dart';
import 'package:tft_guide/ui/pages/ranked/body/button.dart';
import 'package:tft_guide/ui/pages/ranked/body/current_lp.dart';
import 'package:tft_guide/ui/pages/ranked/body/lp_gain.dart';
import 'package:tft_guide/ui/pages/ranked/body/rank.dart';

class RankedBody extends StatelessWidget {
  const RankedBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: double.infinity,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => EloCubit(),
              ),
              BlocProvider<EloGainCubit>(
                create: (_) => EloGainCubit(),
              ),
            ],
            child: const _Content(),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RankCubit()..compute(context.read<EloCubit>().state),
      child: const Column(
        children: [
          RankAsset(),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              CurrentLp(),
              Expanded(
                child: LpGain(),
              ),
            ],
          ),
          SizedBox(height: 10),
          StartGameButton(),
        ],
      ),
    );
  }
}