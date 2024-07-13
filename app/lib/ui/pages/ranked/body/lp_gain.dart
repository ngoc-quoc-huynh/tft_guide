import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';

class LpGain extends StatelessWidget {
  const LpGain({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .headlineLarge
        ?.copyWith(color: Colors.green);
    return BlocBuilder<EloGainCubit, int?>(
      builder: (context, state) => switch (state != null) {
        false => const SizedBox.shrink(),
        true => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '+ $state',
                style: textStyle,
              ),
            ),
          ),
      },
    );
  }
}
