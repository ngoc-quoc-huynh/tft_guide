import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/pages/game/selection_item/chip.dart';

part 'image.dart';
part 'images.dart';
part 'text.dart';

enum SelectionItemState {
  correct,
  wrong,
  selected,
  unselected,
}

sealed class SelectionItem extends StatelessWidget {
  const SelectionItem({
    required this.state,
    required this.onPressed,
    super.key,
  });

  final SelectionItemState state;
  final VoidCallback onPressed;
}
