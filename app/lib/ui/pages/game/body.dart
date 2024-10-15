import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/check_selected_option/cubit.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/check_button.dart';
import 'package:tft_guide/ui/pages/game/item_selection.dart';
import 'package:tft_guide/ui/pages/game/question/body.dart';
import 'package:tft_guide/ui/pages/game/question/header.dart';
import 'package:tft_guide/ui/pages/game/question/question.dart';
import 'package:tft_guide/ui/router/routes.dart';

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
                BlocProvider<SelectedItemOptionValueCubit>(
                  create: (_) => SelectedItemOptionValueCubit(),
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
                        const SizedBox(height: 50),
                        ItemSelection(
                          question: question,
                        ),
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
          ..read<EloGainCubit>().update(eloGain)
          ..read<HydratedEloCubit>().increase(eloGain ?? 0)
          ..goNamed(Routes.rankedPage());
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

  static TranslationsPagesGameQuestionsEn get _translations =>
      Injector.instance.translations.pages.game.questions;
}
