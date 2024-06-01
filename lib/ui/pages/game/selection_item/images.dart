part of 'selection_item.dart';

final class SelectionItemImages extends SelectionItem {
  const SelectionItemImages({
    required this.asset1,
    required this.asset2,
    required super.state,
    required super.onPressed,
    super.key,
  });

  final Asset asset1;
  final Asset asset2;

  @override
  Widget build(BuildContext context) {
    return SelectionChip(
      onPressed: onPressed,
      state: state,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox.shrink(),
          Image.asset(
            asset1.path,
            height: 50,
            width: 50,
          ),
          const Icon(Icons.add),
          Image.asset(
            asset2.path,
            height: 50,
            width: 50,
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
