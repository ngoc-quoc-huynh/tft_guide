import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/ui/pages/game/selection_item/chip.dart';
import 'package:tft_guide/ui/widgets/bloc/builder.dart';
import 'package:tft_guide/ui/widgets/bloc/selector.dart';
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
    required this.isCorrectOption,
    required this.option,
    super.key,
  });

  const factory SelectionItem.text({
    required int index,
    required bool isCorrectOption,
    required QuestionItemOption option,
    Key? key,
  }) = _Text;

  const factory SelectionItem.image({
    required int index,
    required bool isCorrectOption,
    required QuestionItemOption option,
    Key? key,
  }) = _Image;

  const factory SelectionItem.images({
    required int index,
    required bool isCorrectOption,
    required QuestionFullItemOption fullItemOption,
    Key? key,
  }) = _Images;

  final int index;
  final bool isCorrectOption;
  final QuestionItemOption option;

  @protected
  static const imageSize = 50.0;
}

final class _Text extends SelectionItem {
  const _Text({
    required super.index,
    required super.isCorrectOption,
    required super.option,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _Content(
      index: index,
      isCorrectOption: isCorrectOption,
      option: option,
      child: SizedBox(
        height: 35,
        child: Center(
          child: Text(
            option.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}

final class _Image extends SelectionItem {
  const _Image({
    required super.index,
    required super.isCorrectOption,
    required super.option,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _Content(
      index: index,
      isCorrectOption: isCorrectOption,
      option: option,
      child: Center(
        child: FileStorageImage(
          id: option.id,
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
    required super.isCorrectOption,
    required this.fullItemOption,
    super.key,
  }) : super(option: fullItemOption);

  final QuestionFullItemOption fullItemOption;

  @override
  Widget build(BuildContext context) {
    return _Content(
      index: index,
      isCorrectOption: isCorrectOption,
      option: fullItemOption,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox.shrink(),
          FileStorageImage(
            id: fullItemOption.itemId1,
            height: SelectionItem.imageSize,
            width: SelectionItem.imageSize,
          ),
          const Icon(Icons.add),
          FileStorageImage(
            id: fullItemOption.itemId2,
            height: SelectionItem.imageSize,
            width: SelectionItem.imageSize,
          ),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.index,
    required this.isCorrectOption,
    required this.option,
    required this.child,
  });

  final int index;
  final bool isCorrectOption;
  final QuestionItemOption option;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilderWithChild<CheckSelectedItemOptionCubit, bool?>(
      builder: (context, isSelectedCorrect, child) => BlocSelectorWithChild<
          SelectedItemOptionValueCubit, QuestionItemOption?, bool>(
        selector: (selectedOption) => selectedOption == option,
        builder: (context, isSelected, child) => SelectionChip(
          index: index,
          onPressed: () => _onPressed(context),
          state: _determineSelectionItemState(
            isCorrectOption: isCorrectOption,
            isSelected: isSelected,
            isSelectedCorrect: isSelectedCorrect,
          ),
          child: child!,
        ),
        child: child,
      ),
      child: child,
    );
  }

  void _onPressed(BuildContext context) =>
      context.read<SelectedItemOptionValueCubit>().select(option);

  SelectionItemState _determineSelectionItemState({
    required bool isCorrectOption,
    required bool isSelected,
    required bool? isSelectedCorrect,
  }) =>
      switch ((
        isCorrectOption,
        isSelected,
        isSelectedCorrect,
      )) {
        (_, true, null) => SelectionItemState.selected,
        (_, false, null) => SelectionItemState.unselected,
        (true, _, _) => SelectionItemState.correct,
        (false, true, bool()) => SelectionItemState.wrong,
        (false, false, bool()) => SelectionItemState.unselected,
      };
}
