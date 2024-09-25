import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/domain/blocs/check_selected_option/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';
import 'package:tft_guide/ui/widgets/bloc/selector.dart';

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
    ]..shuffle(Injector.instance.random);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _itemOptions.mapIndexed(
        (index, option) {
          final isCorrectOption = option == widget.question.correctOption;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index != 2 ? 20 : 0,
            ),
            child: BlocSelectorWithChild<CheckSelectedItemOptionCubit, bool?,
                bool>(
              selector: (state) => state != null,
              builder: (context, hasChecked, child) => IgnorePointer(
                ignoring: hasChecked,
                child: child,
              ),
              child: switch (widget.question) {
                BaseItemsTextQuestion() ||
                BaseItemsImageQuestion() =>
                  SelectionItem.images(
                    index: index,
                    isCorrectOption: isCorrectOption,
                    fullItemOption: option as QuestionFullItemOption,
                  ),
                FullItemTextQuestion() ||
                TitleImageQuestion() ||
                DescriptionImageQuestion() =>
                  SelectionItem.text(
                    isCorrectOption: isCorrectOption,
                    index: index,
                    option: option,
                  ),
                FullItemImageQuestion() ||
                TitleTextQuestion() ||
                DescriptionTextQuestion() =>
                  SelectionItem.image(
                    index: index,
                    isCorrectOption: isCorrectOption,
                    option: option,
                  ),
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
