import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';

class InitRestartButton extends StatelessWidget {
  const InitRestartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: Injector.instance.nativeApi.restartApp,
      child: Text(Injector.instance.translations.pages.init.restart),
    );
  }
}
