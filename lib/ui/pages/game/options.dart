import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/option_selection/cubit.dart';
import 'package:tft_guide/domain/blocs/show_correct_option/cubit.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/ui/pages/game/option_box.dart';

class Options extends StatefulWidget {
  const Options({
    required this.type,
    required this.correctOption,
    required this.options,
    super.key,
  });

  final QuestionType type;
  final Item correctOption;
  final List<Item> options;

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  late final options = [widget.correctOption, ...widget.options]..shuffle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowCorrectOptionCubit, bool>(
      builder: (context, showCorrectOption) => Column(
        children: options
            .map(
              (option) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: BlocBuilder<OptionSelectionCubit, Item?>(
                  builder: (context, selectedOption) {
                    final showCorrect =
                        option == widget.correctOption && showCorrectOption;
                    return switch (widget.type) {
                      QuestionType.image => OptionBox.byText(
                          onSelect: () => context
                              .read<OptionSelectionCubit>()
                              .select(option),
                          isSelected: option == selectedOption,
                          text: option.name,
                          showCorrect: showCorrect,
                        ),
                      QuestionType.text => OptionBox.byImage(
                          onSelect: () => context
                              .read<OptionSelectionCubit>()
                              .select(option),
                          isSelected: option == selectedOption,
                          asset: option.asset,
                          showCorrect: showCorrect,
                        ),
                    };
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
