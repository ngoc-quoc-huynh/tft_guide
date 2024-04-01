import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/option_selection/cubit.dart';
import 'package:tft_guide/domain/blocs/show_correct_option/cubit.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/static/resources/colors.dart';

// ignore_for_file: avoid-non-ascii-symbols, TODO: Add to i18n

class BaseComponentBody extends StatelessWidget {
  const BaseComponentBody({required this.question, super.key});

  final BaseComponentsQuestion question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          correctItem: question.correctOption,
          type: question.type,
        ),
        const SizedBox(height: 50),
        Expanded(
          child: _Options(
            // TODO: Prevent cast
            correctOption: question.correctOption as FullItem,
            options: question.options as List<FullItem>,
            type: question.type,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.correctItem, required this.type});

  final Item correctItem;
  final QuestionType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Welche Gegenstände ergeben zusammen diesen Gegenstand?',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        switch (type) {
          QuestionType.text => Text(
              '„${correctItem.name}“',
            ),
          QuestionType.image => Image.asset(
              correctItem.asset.path,
              width: 100,
              height: 100,
            ),
        },
      ],
    );
  }
}

// TODO: Refactor
class _Options extends StatefulWidget {
  const _Options({
    required this.type,
    required this.correctOption,
    required this.options,
  });

  final QuestionType type;
  final FullItem correctOption;
  final List<FullItem> options;

  @override
  State<_Options> createState() => _OptionsState();
}

class _OptionsState extends State<_Options> {
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
                    return _OptionBox(
                      onSelect: () =>
                          context.read<OptionSelectionCubit>().select(option),
                      isSelected: option == selectedOption,
                      showCorrect: showCorrect,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            option.component1.asset.path,
                            width: 50,
                            height: 50,
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.add),
                          const SizedBox(width: 20),
                          Image.asset(
                            option.component2.asset.path,
                            width: 50,
                            height: 50,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _OptionBox extends StatelessWidget {
  const _OptionBox({
    required this.onSelect,
    required this.isSelected,
    required this.showCorrect,
    required this.child,
  });

  final VoidCallback onSelect;
  final bool isSelected;
  final bool showCorrect;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.fromBorderSide(
            BorderSide(
              color: switch (showCorrect) {
                true => Colors.green,
                false when isSelected => CustomColors.orange,
                false => Colors.grey,
              },
              width: 2,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
