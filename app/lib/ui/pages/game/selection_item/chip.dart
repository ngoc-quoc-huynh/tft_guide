import 'package:flutter/material.dart';
import 'package:tft_guide/domain/utils/extensions/theme.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';

final class SelectionChip extends StatelessWidget {
  const SelectionChip({
    required this.index,
    required this.child,
    required this.state,
    required this.onPressed,
    super.key,
  });

  final int index;
  final Widget child;
  final SelectionItemState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      tooltip: Injector.instance.translations.pages.game.option(
        index: index + 1,
      ),
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return switch (state) {
      SelectionItemState.correct => theme.customColors.success,
      SelectionItemState.wrong => colorScheme.error,
      SelectionItemState.selected => colorScheme.primary,
      SelectionItemState.unselected => colorScheme.outlineVariant,
    };
  }
}
