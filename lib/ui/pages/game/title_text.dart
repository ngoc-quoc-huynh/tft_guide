import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/ui/pages/game/option_box.dart';

// ignore_for_file: avoid-non-ascii-symbols, TODO: Add to i18n

class TitleQuestionBody extends StatelessWidget {
  const TitleQuestionBody({required this.question, super.key});

  final TitleQuestion question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          correctItem: question.correctOption,
          type: question.type,
        ),
        const SizedBox(height: 50),
        _Options(
          options: [
            question.correctOption,
            question.option1,
            question.option2,
          ],
          type: question.type,
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
        switch (type) {
          QuestionType.text => const Text(
              'Welcher Gegenstand passt zu diesem Titel?',
            ),
          QuestionType.image => const Text(
              'Was für ein Gegenstand ist das gegebene Bild?',
            ),
        },
        const SizedBox(height: 10),
        switch (type) {
          QuestionType.text => Text(
              '„${correctItem.name}“?',
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

class _Options extends StatelessWidget {
  const _Options({
    required this.options,
    required this.type,
  });

  final List<Item> options;
  final QuestionType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final option in options)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: switch (type) {
              QuestionType.text => OptionBox.byImage(asset: option.asset),
              QuestionType.image => OptionBox.byText(text: option.name),
            },
          ),
      ],
    );
  }
}
