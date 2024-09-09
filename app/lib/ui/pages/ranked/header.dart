import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';

class RankedHeader extends StatelessWidget {
  const RankedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      Injector.instance.translations.pages.ranked.header,
      style: getTextStyle(context),
      textAlign: TextAlign.center,
    );
  }

  TextStyle? getTextStyle(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.headlineMedium
        ?.copyWith(color: theme.colorScheme.primary);
  }
}
