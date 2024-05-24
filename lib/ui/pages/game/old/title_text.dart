import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/old/item.dart';
import 'package:tft_guide/domain/models/old/question.dart';
import 'package:tft_guide/ui/pages/game/old/options.dart';

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
        Options(
          correctOption: question.correctOption,
          options: question.options,
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
              textAlign: TextAlign.center,
            ),
          QuestionType.image => const Text(
              'Was für ein Gegenstand ist das gegebene Bild?',
              textAlign: TextAlign.center,
            ),
        },
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
