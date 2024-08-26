import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/correct_answers/cubit.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/blocs/questions_old/bloc.dart';
import 'package:tft_guide/domain/blocs/selected_item/cubit.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/domain/models/question_item2.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/check_button.dart';
import 'package:tft_guide/ui/pages/game/item_selection.dart';
import 'package:tft_guide/ui/pages/game/progress_bar.dart';
import 'package:tft_guide/ui/pages/game/question/body.dart';
import 'package:tft_guide/ui/pages/game/question/header.dart';
import 'package:tft_guide/ui/pages/game/question/question.dart';
import 'package:tft_guide/ui/pages/game/quit_button.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static const routeName = 'game';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameProgressBloc>(
          create: (_) => GameProgressBloc(),
        ),
        BlocProvider<CorrectAnswersCubit>(
          create: (_) => CorrectAnswersCubit(),
        ),
        BlocProvider<QuestionsBloc>(
          create: (_) => QuestionsBloc()
            ..add(
              const QuestionsInitializeEvent(),
            ),
        ),
      ],
      child: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) {
          return switch (state) {
            QuestionsLoadInProgress() ||
            QuestionsLoadOnFailure() =>
              const Scaffold(
                body: LoadingIndicator(),
              ),
            QuestionsLoadOnSuccess(:final questions) => Scaffold(
                appBar: AppBar(
                  leading: const QuitButton(),
                  title: const GameProgressBar(),
                  forceMaterialTransparency: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.horizontalPadding,
                  ),
                  child: _Body(questions),
                ),
              ),
          };
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body(this.questions);

  final List<Question> questions;

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
        itemCount: widget.questions.length,
        itemBuilder: (context, index) {
          final question = widget.questions[index];
          final correctItem = question.correctItem;
          return MultiBlocProvider(
            providers: [
              BlocProvider<CheckSelectedItemCubit>(
                create: (_) => CheckSelectedItemCubit(
                  correctItem,
                ),
              ),
              BlocProvider<SelectedItemCubit>(
                create: (_) => SelectedItemCubit(),
              ),
            ],
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      GameQuestion(
                        // TODO: Extract i18n and maybe widget
                        header: QuestionHeader(
                          text: switch (question) {
                            BaseItemsTextQuestion() ||
                            BaseItemsImageQuestion() =>
                              'Which items together make up this item?',
                            FullItemTextQuestion() ||
                            FullItemImageQuestion() =>
                              'Which item results if you combine these two?',
                            TitleTextQuestion() =>
                              'Which item matches this title?',
                            TitleImageQuestion() =>
                              'Which title matches this item?',
                            DescriptionTextQuestion() =>
                              'Which item matches this description?',
                            DescriptionImageQuestion() =>
                              'Which description matches this item?',
                          },
                        ),
                        // TODO: Extract widget
                        body: switch (question) {
                          BaseItemsTextQuestion() ||
                          TitleTextQuestion() =>
                            QuestionBodyTitle(
                              text: correctItem.name,
                            ),
                          BaseItemsImageQuestion() ||
                          TitleImageQuestion() =>
                            QuestionBodyImage(
                              asset: correctItem.asset,
                            ),
                          FullItemTextQuestion(
                            :final correctItem as QuestionFullItem
                          ) ||
                          FullItemImageQuestion(
                            :final correctItem as QuestionFullItem
                          ) =>
                            QuestionBodyImages(
                              asset1: correctItem.baseItem1.asset,
                              asset2: correctItem.baseItem2.asset,
                            ),
                          DescriptionTextQuestion() ||
                          DescriptionImageQuestion() =>
                            QuestionBodyDescription(
                              text: correctItem.description,
                            ),
                        },
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 5,
                        child: ItemSelection(
                          question: question,
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const CheckButton(),
              ],
            ),
          );
        },
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
