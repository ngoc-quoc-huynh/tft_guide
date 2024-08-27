import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/selected_item/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';

class ItemSelection extends StatefulWidget {
  const ItemSelection({
    required this.question,
    super.key,
  });

  final Question question;

  @override
  State<ItemSelection> createState() => _ItemSelectionState();
}

class _ItemSelectionState extends State<ItemSelection> {
  late final List<QuestionItemOption> _itemOptions;

  @override
  void initState() {
    super.initState();
    _itemOptions = [
      widget.question.correctOption,
      ...widget.question.otherOptions,
    ]..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _itemOptions
          .mapIndexed(
            (index, item) => Padding(
              padding: EdgeInsets.only(
                bottom: index != 2 ? 20 : 0,
              ),
              child: BlocBuilder<CheckSelectedItemOptionCubit, bool?>(
                builder: (context, isCorrect) => IgnorePointer(
                  ignoring: isCorrect != null,
                  child:
                      BlocBuilder<SelectedItemOptionCubit, QuestionItemOption?>(
                    builder: (context, selectedOption) =>
                        switch (widget.question) {
                      BaseItemsTextQuestion() ||
                      BaseItemsImageQuestion() =>
                        SelectionItem.images(
                          index: index,
                          itemId1: (item as QuestionFullItemOption).itemId1,
                          itemId2: item.itemId2,
                          state: _determineSelectionItemState(
                            item,
                            selectedOption,
                            isCorrect,
                          ),
                          onPressed: () => context
                              .read<SelectedItemOptionCubit>()
                              .select(item),
                        ),
                      FullItemTextQuestion() ||
                      TitleImageQuestion() ||
                      DescriptionImageQuestion() =>
                        SelectionItem.text(
                          index: index,
                          text: item.name,
                          state: _determineSelectionItemState(
                            item,
                            selectedOption,
                            isCorrect,
                          ),
                          onPressed: () => context
                              .read<SelectedItemOptionCubit>()
                              .select(item),
                        ),
                      FullItemImageQuestion() ||
                      TitleTextQuestion() ||
                      DescriptionTextQuestion() =>
                        SelectionItem.image(
                          index: index,
                          id: item.id,
                          state: _determineSelectionItemState(
                            item,
                            selectedOption,
                            isCorrect,
                          ),
                          onPressed: () => context
                              .read<SelectedItemOptionCubit>()
                              .select(item),
                        ),
                    },
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  SelectionItemState _determineSelectionItemState(
    QuestionItemOption itemOption,
    QuestionItemOption? selectedItemOption,
    bool? isCorrect,
  ) =>
      switch (itemOption == selectedItemOption) {
        true when isCorrect == false => SelectionItemState.wrong,
        _
            when isCorrect != null &&
                itemOption == widget.question.correctOption =>
          SelectionItemState.correct,
        true => SelectionItemState.selected,
        _ => SelectionItemState.unselected,
      };
}
