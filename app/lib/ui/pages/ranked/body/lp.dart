import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/utils/mixins/animation.dart';

class RankedLp extends StatelessWidget {
  const RankedLp({
    required this.lp,
    super.key,
  });

  final int lp;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _CurrentLp(lp),
          const Expanded(
            child: _LpGain(),
          ),
        ],
      ),
    );
  }
}

class _CurrentLp extends StatelessWidget with AnimationMixin {
  const _CurrentLp(this.lp);

  final int lp;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EloGainCubit, int?>(
      builder: (context, eloGain) => AnimatedFlipCounter(
        value: lp,
        suffix: Injector.instance.translations.pages.ranked.lpSuffix,
        textStyle: Theme.of(context).textTheme.headlineSmall,
        curve: Curves.easeInOutQuad,
        duration: computeRankAnimationDuration(eloGain),
      ),
    );
  }
}

class _LpGain extends StatelessWidget {
  const _LpGain();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EloGainCubit, int?>(
      builder: (BuildContext context, int? lpGain) => switch (lpGain) {
        null => const SizedBox.shrink(),
        int() => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              '+ $lpGain',
              style: _getTextStyle(context),
            ),
          ),
      },
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.headlineSmall
        ?.copyWith(color: theme.customColors.success);
  }
}
