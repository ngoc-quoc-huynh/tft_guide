import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';

class LpGain extends StatelessWidget {
  const LpGain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EloGainCubit, int?>(
      builder: (context, state) => switch (state != null) {
        false => const SizedBox.shrink(),
        true => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '+ $state',
                style: _getTextStyle(context),
              ),
            ),
          ),
      },
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.headlineLarge
        ?.copyWith(color: theme.customColors.success);
  }
}
