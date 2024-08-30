import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/check_selected_item/cubit.dart';
import 'package:tft_guide/domain/blocs/correct_answers/cubit.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/blocs/selected_item/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/check_button.dart';
import 'package:tft_guide/ui/pages/game/item_selection.dart';
import 'package:tft_guide/ui/pages/game/question/body.dart';
import 'package:tft_guide/ui/pages/game/question/header.dart';
import 'package:tft_guide/ui/pages/game/question/question.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';

class GameBody extends StatefulWidget {
  const GameBody({
    required this.questions,
    super.key,
  });

  final List<Question> questions;

  @override
  State<GameBody> createState() => _GameBodyState();
}

class _GameBodyState extends State<GameBody> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.horizontalPadding),
      child: BlocListener<GameProgressBloc, GameProgressState>(
        listener: _onGameProgressStateChange,
        child: PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            final question = widget.questions[index];
            final correctOption = question.correctOption;
            return MultiBlocProvider(
              providers: [
                BlocProvider<CheckSelectedItemOptionCubit>(
                  create: (_) => CheckSelectedItemOptionCubit(
                    correctOption,
                  ),
                ),
                BlocProvider<SelectedItemOptionCubit>(
                  create: (_) => SelectedItemOptionCubit(),
                ),
              ],
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        GameQuestion(
                          header: _Header(question),
                          body: switch (question) {
                            BaseItemsTextQuestion() ||
                            TitleTextQuestion() =>
                              QuestionBody.title(
                                text: correctOption.name,
                              ),
                            BaseItemsImageQuestion() ||
                            TitleImageQuestion() =>
                              QuestionBody.image(
                                id: correctOption.id,
                              ),
                            FullItemTextQuestion(
                              :final correctOption as QuestionFullItemOption
                            ) ||
                            FullItemImageQuestion(
                              :final correctOption as QuestionFullItemOption
                            ) =>
                              QuestionBody.images(
                                itemId1: correctOption.itemId1,
                                itemId2: correctOption.itemId2,
                              ),
                            DescriptionTextQuestion() ||
                            DescriptionImageQuestion() =>
                              QuestionBody.description(
                                text: correctOption.description,
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
            duration: const Duration(milliseconds: 300),
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

class _Header extends QuestionHeader {
  _Header(Question question)
      : super(
          text: switch (question) {
            BaseItemsTextQuestion() ||
            BaseItemsImageQuestion() =>
              _translations.baseItemCombine,
            FullItemTextQuestion() ||
            FullItemImageQuestion() =>
              _translations.fullItemCombine,
            TitleTextQuestion() => _translations.titleText,
            TitleImageQuestion() => _translations.titleImage,
            DescriptionTextQuestion() => _translations.descriptionText,
            DescriptionImageQuestion() => _translations.descriptionImage,
          },
        );

  static TranslationsPagesGameQuestionsDe get _translations =>
      Injector.instance.translations.pages.game.questions;
}