import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/game/quit/dialog.dart';

class QuitButton extends StatelessWidget {
  const QuitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<GameProgressBloc, GameProgressState, bool>(
      selector: (state) => state.currentProgress == 0,
      builder: (context, isFirstLevel) => PopScope(
        canPop: isFirstLevel,
        onPopInvokedWithResult: (didPop, _) => unawaited(
          _onPopInvoked(context, didPop),
        ),
        child: IconButton(
          tooltip: Injector.instance.translations.pages.game.quit.tooltip,
          icon: const Icon(Icons.close),
          onPressed: () => unawaited(_onQuit(context)),
        ),
      ),
    );
  }

  Future<void> _onPopInvoked(BuildContext context, bool didPop) async {
    if (didPop) {
      return;
    }
    await _onQuit(context);
  }

  Future<void> _onQuit(BuildContext context) async {
    final isQuitting = await QuitDialog.show(context);
    if (context.mounted && isQuitting) {
      context.pop();
    }
  }
}
