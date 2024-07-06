import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';

class FeedbackBottomSheet extends StatelessWidget {
  const FeedbackBottomSheet._(this.isCorrect);

  final bool isCorrect;

  static Future<void> show(
    BuildContext context, {
    required bool isCorrect,
  }) =>
      showModalBottomSheet<void>(
        isDismissible: false,
        barrierColor: Colors.transparent,
        enableDrag: false,
        context: context,
        builder: (_) => BlocProvider.value(
          value: context.read<GameProgressBloc>(),
          child: FeedbackBottomSheet._(isCorrect),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return BottomSheet(
      enableDrag: false,
      onClosing: () {
        return;
      },
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: color,
                ),
                const SizedBox(width: 10),
                // TODO: Retrieve this text from i18n randomly
                Text(
                  'Challenger on my way!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: color),
                ),
              ],
            ),
            const SizedBox(height: 10),
            BlocListener<GameProgressBloc, GameProgressState>(
              listener: _onGameProgressStateChange,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: FilledButton(
                  onPressed: () => _onContinue(context),
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get _color => switch (isCorrect) {
        false => Colors.red,
        true => Colors.green,
      };

  void _onGameProgressStateChange(
    BuildContext context,
    GameProgressState state,
  ) {
    if (state is GameProgressFinished) {
      context.goNamed(RankedPage.routeName);
    }
  }

  void _onContinue(BuildContext context) {
    context.pop();
    context.read<GameProgressBloc>().add(const GameProgressNextEvent());
  }
}
