import 'package:flutter/material.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';

final class SelectionChip extends StatelessWidget {
  const SelectionChip({
    required this.child,
    required this.state,
    required this.onPressed,
    super.key,
  });

  final Widget child;
  final SelectionItemState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: _getColor(context),
          width: 2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      label: child,
      onPressed: onPressed,
    );
  }

  Color _getColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (state) {
      SelectionItemState.correct => Colors.green,
      SelectionItemState.wrong => colorScheme.error,
      SelectionItemState.selected => colorScheme.primary,
      SelectionItemState.unselected => colorScheme.outlineVariant,
    };
  }
}
