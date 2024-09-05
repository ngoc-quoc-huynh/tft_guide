import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.value,
    this.maxValue = 100,
    super.key,
  });

  final double value;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return FAProgressBar(
      backgroundColor: colorScheme.primaryContainer,
      progressColor: colorScheme.primary,
      size: 16,
      currentValue: value,
      maxValue: maxValue,
    );
  }
}
