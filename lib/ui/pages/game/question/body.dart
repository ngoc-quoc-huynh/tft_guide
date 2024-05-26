// ignore_for_file: prefer-single-widget-per-file,
// otherwise we have to create a library and use part/parts of.

import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/assets.dart';

sealed class QuestionBody extends StatelessWidget {
  const QuestionBody({super.key});
}

sealed class QuestionBodyText extends QuestionBody {
  const QuestionBodyText({
    required this.text,
    super.key,
  });

  final String text;

  TextStyle? getTextStyle(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle(context),
    );
  }
}

final class QuestionBodyTitle extends QuestionBodyText {
  const QuestionBodyTitle({
    required super.text,
    super.key,
  });

  @override
  TextStyle? getTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge;
}

final class QuestionBodyDescription extends QuestionBodyText {
  const QuestionBodyDescription({
    required super.text,
    super.key,
  });

  @override
  TextStyle? getTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium;
}

final class QuestionBodyImage extends QuestionBody {
  const QuestionBodyImage({required this.asset, super.key});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    // TODO: Extract the widget or the size
    return Image.asset(
      asset.path,
      height: 100,
      width: 100,
    );
  }
}

final class QuestionBodyImages extends QuestionBody {
  const QuestionBodyImages({
    required this.asset1,
    required this.asset2,
    super.key,
  });

  final Asset asset1;
  final Asset asset2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          asset1.path,
          height: 100,
          width: 100,
        ),
        const Icon(Icons.add),
        Image.asset(
          asset1.path,
          height: 100,
          width: 100,
        ),
      ],
    );
  }
}
