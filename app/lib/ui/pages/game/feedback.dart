import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';

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
    return PopScope(
      canPop: false,
      child: BottomSheet(
        enableDrag: false,
        onClosing: () {
          return;
        },
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Sizes.maxWidgetWith),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      _icon,
                      color: _getColor(context),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        Injector.instance.feedbackApi
                            .getFeedback(isCorrect: isCorrect),
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: _getColor(context)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: FilledButton(
                    onPressed: () => _onContinue(context),
                    child:
                        Text(Injector.instance.translations.pages.game.proceed),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData get _icon => switch (isCorrect) {
        false => Icons.error,
        true => Icons.check_circle,
      };

  Color _getColor(BuildContext context) {
    final theme = Theme.of(context);
    return switch (isCorrect) {
      false => theme.colorScheme.error,
      true => theme.customColors.success,
    };
  }

  void _onContinue(BuildContext context) => context
    ..pop()
    ..read<GameProgressBloc>().add(const GameProgressNextEvent());
}
