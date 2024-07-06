import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/feedback/cubit.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

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
                Expanded(
                  child: BlocProvider<FeedbackCubit>(
                    create: (_) =>
                        FeedbackCubit()..getFeedback(isCorrect: isCorrect),
                    child: BlocBuilder<FeedbackCubit, String?>(
                      builder: (context, feedback) => switch (feedback) {
                        null => const LoadingIndicator(),
                        String() => Text(
                            feedback,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: color),
                          ),
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FractionallySizedBox(
              widthFactor: 1,
              child: FilledButton(
                onPressed: () => _onContinue(context),
                child: const Text('Continue'),
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

  void _onContinue(BuildContext context) {
    context.pop();
    context.read<GameProgressBloc>().add(const GameProgressNextEvent());
  }
}
