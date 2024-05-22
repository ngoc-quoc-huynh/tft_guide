import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/ui/pages/game/page.dart';

class StartGameButton extends StatelessWidget {
  const StartGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => context.goNamed(GamePage.routeName),
      child: const Text('Start Game'),
    );
  }
}
