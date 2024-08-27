import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';

class GameProgressBar extends StatelessWidget {
  const GameProgressBar({
    required this.totalQuestion,
    super.key,
  });

  final int totalQuestion;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocSelector<GameProgressBloc, GameProgressState, int>(
      selector: (state) => state.currentProgress,
      builder: (context, currentProgress) => FAProgressBar(
        backgroundColor: colorScheme.primaryContainer,
        progressColor: colorScheme.primary,
        size: 16,
        currentValue: currentProgress.toDouble(),
        maxValue: totalQuestion.toDouble(),
      ),
    );
  }
}
