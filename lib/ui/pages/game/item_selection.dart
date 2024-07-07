import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/selected_item/cubit.dart';
import 'package:tft_guide/domain/models/question_item.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';

class ItemSelection extends StatefulWidget {
  const ItemSelection({
    required this.correctItem,
    required this.otherItems,
    super.key,
  });

  final QuestionItem correctItem;
  final List<QuestionItem> otherItems;

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  late final List<QuestionItem> _items;

  @override
  void initState() {
    super.initState();
    _items = [widget.correctItem, ...widget.otherItems]..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _items
          .mapIndexed(
            (index, item) => Padding(
              padding: EdgeInsets.only(
                bottom: index != 2 ? 20 : 0,
              ),
              child: BlocBuilder<CheckSelectedItemCubit, bool?>(
                builder: (context, isCorrect) => IgnorePointer(
                  ignoring: isCorrect != null,
                  child: BlocBuilder<SelectedItemCubit, QuestionItem?>(
                    builder: (context, selectedItem) => SelectionItemImage(
                      asset: item.asset,
                      state: _determineSelectionItemState(
                        item,
                        selectedItem,
                        isCorrect,
                      ),
                      onPressed: () =>
                          context.read<SelectedItemCubit>().select(item),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  SelectionItemState _determineSelectionItemState(
    QuestionItem item,
    QuestionItem? selectedItem,
    bool? isCorrect,
  ) =>
      switch (item == selectedItem) {
        true when isCorrect == false => SelectionItemState.wrong,
        _ when isCorrect != null && item == widget.correctItem =>
          SelectionItemState.correct,
        true => SelectionItemState.selected,
        _ => SelectionItemState.unselected,
      };
}
