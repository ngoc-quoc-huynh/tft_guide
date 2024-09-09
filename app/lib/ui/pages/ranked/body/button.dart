import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/router/routes.dart';

class StartGameButton extends StatelessWidget {
  const StartGameButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => context.goNamed(Routes.gamePage()),
      child: Text(Injector.instance.translations.pages.ranked.startGame),
    );
  }
}
