import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/ui/pages/game/quit_dialog.dart';

class QuitButton extends StatelessWidget {
  const QuitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => unawaited(
        _onPopInvoked(context, didPop),
      ),
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: () => unawaited(_onQuit(context)),
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
