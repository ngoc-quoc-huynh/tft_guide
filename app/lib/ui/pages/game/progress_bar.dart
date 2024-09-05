import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/ui/widgets/progress_bar.dart';

class GameProgressBar extends StatelessWidget {
  const GameProgressBar({
    required this.totalQuestion,
    super.key,
  });

  final int totalQuestion;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameProgressBloc, GameProgressState, int>(
      selector: (state) => state.currentProgress,
      builder: (context, currentProgress) => ProgressBar(
        value: currentProgress.toDouble(),
        maxValue: totalQuestion.toDouble(),
      ),
    );
  }
}
