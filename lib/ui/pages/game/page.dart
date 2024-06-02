import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/check_button.dart';
import 'package:tft_guide/ui/pages/game/progress_bar.dart';
import 'package:tft_guide/ui/pages/game/question/body.dart';
import 'package:tft_guide/ui/pages/game/question/header.dart';
import 'package:tft_guide/ui/pages/game/question/question.dart';
import 'package:tft_guide/ui/pages/game/quit_button.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';

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
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.horizontalPadding,
          ),
          child: Column(
            children: [
              Expanded(
                // TODO: Use ListView.builder/Slivers
                child: ListView(
                  children: [
                    SelectionItemText(
                      text: 'Adaptive Helm',
                      state: SelectionItemState.selected,
                      onPressed: () {
                        return;
                      },
                    ),
                    const SizedBox(height: 20),
                    SelectionItemImage(
                      asset: Assets.chainVest,
                      onPressed: () {
                        return;
                      },
                      state: SelectionItemState.correct,
                    ),
                    const SizedBox(height: 20),
                    SelectionItemImages(
                      asset1: Assets.bfSword,
                      asset2: Assets.bfSword,
                      onPressed: () {
                        return;
                      },
                      state: SelectionItemState.unselected,
                    ),
                    const SizedBox(height: 20),
                    SelectionItemImages(
                      asset1: Assets.bfSword,
                      asset2: Assets.bfSword,
                      state: SelectionItemState.wrong,
                      onPressed: () {
                        return;
                      },
                    ),
                    const ExampleBody(),
                  ],
                ),
              ),
              const CheckButton(),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file, for testing purpose.
class ExampleBody extends StatelessWidget {
  const ExampleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
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
            text: 'Front: Gain 35 armor and magic resistance. Additionally,'
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
    );
  }
}
