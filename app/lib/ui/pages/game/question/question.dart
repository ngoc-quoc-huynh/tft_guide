import 'package:flutter/material.dart';
import 'package:tft_guide/ui/pages/game/question/body.dart';
import 'package:tft_guide/ui/pages/game/question/header.dart';

class GameQuestion extends StatelessWidget {
  const GameQuestion({
    required this.header,
    required this.body,
    super.key,
  });

  final QuestionHeader header;
  final QuestionBody body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        header,
        const SizedBox(height: 20),
        body,
      ],
    );
  }
}
