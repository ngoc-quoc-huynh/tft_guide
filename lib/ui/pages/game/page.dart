import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/pages/game/feedback.dart';
import 'package:tft_guide/ui/pages/game/progress_bar.dart';
import 'package:tft_guide/ui/pages/game/question/body.dart';
import 'package:tft_guide/ui/pages/game/question/header.dart';
import 'package:tft_guide/ui/pages/game/question/question.dart';
import 'package:tft_guide/ui/pages/game/quit_button.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static const routeName = 'game';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameProgressBloc>(
      create: (_) => GameProgressBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: const QuitButton(),
          title: const GameProgressBar(),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () => unawaited(
              FeedbackBottomSheet.show(context),
            ),
            child: const Text('Next'),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GameQuestion(
                header: QuestionHeader(
                  text: 'Which items together make up this item?',
                ),
                body: QuestionBodyImage(
                  asset: Assets.bfSword,
                ),
              ),
              Divider(),
              GameQuestion(
                header: QuestionHeader(
                  text: 'Which items together make up this item?',
                ),
                body: QuestionBodyImages(
                  asset1: Assets.bfSword,
                  asset2: Assets.chainVest,
                ),
              ),
              Divider(),
              GameQuestion(
                header: QuestionHeader(
                  text: 'Which items together make up this item?',
                ),
                body: QuestionBodyDescription(
                  text:
                      'Front: Gain 35 armor and magic resistance. Additionally,'
                      ' gain '
                      '1 mana when you are attacked. Back: Gain 15 AP and gain '
                      '10 '
                      'mana every 3 seconds.',
                ),
              ),
              Divider(),
              GameQuestion(
                header: QuestionHeader(
                  text: 'Which item matches this title?',
                ),
                body: QuestionBodyTitle(
                  text: 'B.F. Sword',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
