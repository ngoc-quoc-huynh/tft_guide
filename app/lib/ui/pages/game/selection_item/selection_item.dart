import 'package:flutter/material.dart';
import 'package:tft_guide/ui/pages/game/selection_item/chip.dart';
import 'package:tft_guide/ui/widgets/file_storage_image.dart';

enum SelectionItemState {
  correct,
  wrong,
  selected,
  unselected,
}

sealed class SelectionItem extends StatelessWidget {
  const SelectionItem({
    required this.index,
    required this.state,
    required this.onPressed,
    super.key,
  });

  const factory SelectionItem.text({
    required String text,
    required int index,
    required SelectionItemState state,
    required VoidCallback onPressed,
    Key? key,
  }) = _Text;

  const factory SelectionItem.image({
    required String id,
    required int index,
    required SelectionItemState state,
    required VoidCallback onPressed,
    Key? key,
  }) = _Image;

  const factory SelectionItem.images({
    required String itemId1,
    required String itemId2,
    required int index,
    required SelectionItemState state,
    required VoidCallback onPressed,
    Key? key,
  }) = _Images;

  final int index;
  final SelectionItemState state;
  final VoidCallback onPressed;

  @protected
  static const imageSize = 50.0;
}

final class _Text extends SelectionItem {
  const _Text({
    required this.text,
    required super.index,
    required super.state,
    required super.onPressed,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectionChip(
      index: index,
      onPressed: onPressed,
      state: state,
      child: SizedBox(
        height: 35,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

final class _Image extends SelectionItem {
  const _Image({
    required this.id,
    required super.index,
    required super.state,
    required super.onPressed,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return SelectionChip(
      index: index,
      onPressed: onPressed,
      state: state,
      child: Center(
        child: FileStorageImage(
          id: id,
          height: SelectionItem.imageSize,
          width: SelectionItem.imageSize,
        ),
      ),
    );
  }
}

final class _Images extends SelectionItem {
  const _Images({
    required super.index,
    required this.itemId1,
    required this.itemId2,
    required super.state,
    required super.onPressed,
    super.key,
  });

  final String itemId1;
  final String itemId2;

  @override
  Widget build(BuildContext context) {
    return SelectionChip(
      index: index,
      onPressed: onPressed,
      state: state,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox.shrink(),
          FileStorageImage(
            id: itemId1,
            height: SelectionItem.imageSize,
            width: SelectionItem.imageSize,
          ),
          const Icon(Icons.add),
          FileStorageImage(
            id: itemId2,
            height: SelectionItem.imageSize,
            width: SelectionItem.imageSize,
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
