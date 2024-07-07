import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/correct_answers/cubit.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/blocs/selected_item/cubit.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/domain/models/question_item.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/check_button.dart';
import 'package:tft_guide/ui/pages/game/item_selection.dart';
import 'package:tft_guide/ui/pages/game/progress_bar.dart';
import 'package:tft_guide/ui/pages/game/question/body.dart';
import 'package:tft_guide/ui/pages/game/question/header.dart';
import 'package:tft_guide/ui/pages/game/question/question.dart';
import 'package:tft_guide/ui/pages/game/quit_button.dart';
import 'package:tft_guide/ui/pages/game/selection_item/selection_item.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static const routeName = 'game';

  @override
  Widget build(BuildContext context) {
    //  print(context.read<EloGainCubit>().state);
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameProgressBloc>(
          create: (_) => GameProgressBloc(),
        ),
        BlocProvider<CorrectAnswersCubit>(
          create: (_) => CorrectAnswersCubit(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const QuitButton(),
          title: const GameProgressBar(),
          forceMaterialTransparency: true,
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.horizontalPadding,
          ),
          child: _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameProgressBloc, GameProgressState>(
      listener: _onGameProgressStateChange,
      child: PageView.builder(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        // TODO: Retrieve itemCount
        itemCount: 10,
        itemBuilder: (context, index) => MultiBlocProvider(
          providers: [
            BlocProvider<CheckSelectedItemCubit>(
              create: (_) => CheckSelectedItemCubit(
                const QuestionBaseItem(
                  name: 'B.F Sword',
                  description: '10 Attack Damage',
                  asset: Assets.bfSword,
                ),
              ),
            ),
            BlocProvider<SelectedItemCubit>(
              create: (_) => SelectedItemCubit(),
            ),
          ],
          child: const Column(
            children: [
              ExampleBody(
                question: DescriptionTextQuestion(
                  correctItem: QuestionBaseItem(
                    name: 'B.F Sword',
                    description: '10 Attack Damage',
                    asset: Assets.bfSword,
                  ),
                  otherItems: <QuestionBaseItem>[
                    QuestionBaseItem(
                      name: 'Chain Vest',
                      description: '10 Armor',
                      asset: Assets.chainVest,
                    ),
                    QuestionBaseItem(
                      name: 'Tear of the Goddess',
                      description: '10 Mage',
                      asset: Assets.tearOfTheGoddess,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CheckButton(),
            ],
          ),
        ),
      ),
    );
  }

  void _onGameProgressStateChange(
    BuildContext context,
    GameProgressState state,
  ) {
    switch (state) {
      case GameProgressInProgress():
        unawaited(
          _controller.animateToPage(
            state.currentProgress,
            // TODO: Adjust values
            duration: const Duration(
              milliseconds: 300,
            ),
            curve: Curves.easeInOutCubic,
          ),
        );
      case GameProgressFinished():
        final correctAnswers = context.read<CorrectAnswersCubit>().state;
        final eloGain = switch (correctAnswers) {
          0 => null,
          _ => correctAnswers,
        };

        context
          ..read<EloGainCubit>().gain(eloGain)
          ..goNamed(RankedPage.routeName);
    }
  }
}

// ignore: prefer-single-widget-per-file, for testing purpose.
class ExampleBody extends StatelessWidget {
  const ExampleBody({required this.question, super.key});

  final DescriptionTextQuestion question;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          GameQuestion(
            header: const QuestionHeader(
              text: 'Which item matches this description?',
            ),
            body: QuestionBodyDescription(
              text: question.correctItem.description,
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: ItemSelection(
              correctItem: question.correctItem,
              otherItems: question.otherItems,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file, for testing purpose.
class AllPossibilitiesBody extends StatelessWidget {
  const AllPossibilitiesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        const GameQuestion(
          header: QuestionHeader(
            text: 'Which items together make up this item?',
          ),
          body: QuestionBodyImage(
            asset: Assets.bfSword,
          ),
        ),
        const Divider(),
        const GameQuestion(
          header: QuestionHeader(
            text: 'Which items together make up this item?',
          ),
          body: QuestionBodyImages(
            asset1: Assets.bfSword,
            asset2: Assets.chainVest,
          ),
        ),
        const Divider(),
        const GameQuestion(
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
        const Divider(),
        const GameQuestion(
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
