import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/domain/blocs/rank/cubit.dart';
import 'package:tft_guide/domain/models/rank.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class CurrentLp extends StatelessWidget {
  const CurrentLp({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineLarge;
    return BlocBuilder<RankCubit, Rank?>(
      builder: (context, rank) => AnimatedFlipCounter(
        value: rank?.lp ?? 0,
        suffix: ' LP',
        duration: _computeAnimationDuration(context.read<EloGainCubit>().state),
        textStyle: textStyle,
        curve: Curves.easeInOutQuad,
      ),
    );
  }

  Duration _computeAnimationDuration(int? eloGain) => lerpDuration(
        const Duration(milliseconds: 500),
        const Duration(milliseconds: 1500),
        (eloGain ?? 0) / Sizes.questionsAmount,
      );
}
