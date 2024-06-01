part of 'selection_item.dart';

final class SelectionItemText extends SelectionItem {
  const SelectionItemText({
    required this.text,
    required super.state,
    required super.onPressed,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectionChip(
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
