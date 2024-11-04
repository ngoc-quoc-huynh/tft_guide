import 'package:flutter/material.dart';

class ItemDetailCardTitle extends StatelessWidget {
  const ItemDetailCardTitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.titleLarge?.copyWith(
        color: theme.colorScheme.primary,
      ),
    );
  }
}
