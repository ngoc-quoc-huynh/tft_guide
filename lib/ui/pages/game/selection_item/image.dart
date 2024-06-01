part of 'selection_item.dart';

final class SelectionItemImage extends SelectionItem {
  const SelectionItemImage({
    required this.asset,
    required super.state,
    required super.onPressed,
    super.key,
  });

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return SelectionChip(
      onPressed: onPressed,
      state: state,
      child: Center(
        child: Image.asset(
          asset.path,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
