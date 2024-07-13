import 'package:flutter/material.dart';

class RankedHeader extends StatelessWidget {
  const RankedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      'Ready to prove your mastery of TFT?\nStart the game now!',
      style: theme.textTheme.headlineMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }
}
