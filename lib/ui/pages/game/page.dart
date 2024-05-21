// TODO: Remove this
// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/items/bloc.dart';
import 'package:tft_guide/domain/blocs/option_selection/cubit.dart';
import 'package:tft_guide/domain/blocs/question_evaluation/bloc.dart';
import 'package:tft_guide/domain/blocs/questions/bloc.dart';
import 'package:tft_guide/domain/blocs/show_correct_option/cubit.dart';
import 'package:tft_guide/domain/models/item.dart';
import 'package:tft_guide/domain/models/question.dart';
import 'package:tft_guide/ui/pages/game/base_component.dart';
import 'package:tft_guide/ui/pages/game/description_text.dart';
import 'package:tft_guide/ui/pages/game/full_item.dart';
import 'package:tft_guide/ui/pages/game/title_text.dart';
import 'package:tft_guide/ui/widgets/background.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static const routeName = 'game';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocProvider<QuestionsBloc>(
      create: (_) => _createQuestionsBloc(context),
      lazy: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
          centerTitle: true,
          title: FAProgressBar(
            backgroundColor: colorScheme.primary,
            progressColor: colorScheme.secondary,
            size: 16,
            maxValue: 10,
            currentValue: 1,
          ),
        ),
        body: Background(
          child: SafeArea(
            child: BlocBuilder<QuestionsBloc, QuestionsState>(
              builder: (context, state) {
                // TitleQuestion (Base/Full)
                // Image -> Was für ein Gegenstand ist das gegebene Bild
                // Text -> Wie sieht der folgende Gegenstand mit diesem Titel aus?
                // DescriptionQuestion (Base/Full)
                // Image -> Wie sieht der folgende Gegenstand mit dieser Beschreibung aus?
                // Text -> Welcher Gegenstand passt zu dieser Beschreibung?
                // BaseComponentsQuestion
                // Image -> Welche Gegenstände ergeben zusammen diesen Gegenstand?
                // Text -> Welche Gegenstände ergeben zusammen diesen Gegenstand?
                // FullItemQuestion
                // Image -> Welcher Gegenstand ergibt sich, wenn man diese zwei kombiniert?
                // Text -> Welcher Gegenstand ergibt sich, wenn man diese zwei kombiniert?

                // TODO: Use switch
                if (state is QuestionsLoadOnSuccess) {
                  final questions = state.questions;
                  return PageView.builder(
                    itemCount: questions.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider<OptionSelectionCubit>(
                            create: (_) => OptionSelectionCubit(),
                          ),
                          BlocProvider(
                            create: (_) => ShowCorrectOptionCubit(),
                          ),
                        ],
                        // TODO: Extract widget and remove builder
                        child: Builder(
                          builder: (context) => Padding(
                            // TODO: Adjust padding
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Expanded(
                                  child: switch (question) {
                                    TitleQuestion() => TitleQuestionBody(
                                        question: question,
                                      ),
                                    DescriptionQuestion() =>
                                      DescriptionQuestionBody(
                                        question: question,
                                      ),
                                    BaseComponentsQuestion() =>
                                      BaseComponentBody(
                                        question: question,
                                      ),
                                    FullItemQuestion() =>
                                      FullItemBody(question: question),
                                  },
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: BlocProvider(
                                    create: (_) =>
                                        QuestionEvaluationBloc(question),
                                    child: BlocListener<QuestionEvaluationBloc,
                                        QuestionEvaluationState>(
                                      listener: (context, state) => unawaited(
                                        showModalBottomSheet<void>(
                                          context: context,
                                          useRootNavigator: true,
                                          backgroundColor: Colors.transparent,
                                          barrierColor: Colors.transparent,
                                          isDismissible: false,
                                          builder: (_) => Container(
                                            padding: const EdgeInsets.all(20),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text('Feedback'),
                                                const SizedBox(height: 20),
                                                SizedBox(
                                                  width: double.infinity,
                                                  // TODO: Button als Widget extrahieren
                                                  child: ElevatedButton(
                                                    // TODO: Navigate to next question
                                                    onPressed: () =>
                                                        context.pop(),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          colorScheme.secondary,
                                                    ),
                                                    child: const Text(
                                                      'WEITER',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: BlocSelector<OptionSelectionCubit,
                                          Item?, bool>(
                                        selector: (selectedOption) =>
                                            selectedOption != null,
                                        builder: (
                                          context,
                                          hasSelectedOption,
                                        ) =>
                                            // TODO: Disable color anpassen und Button vllt extrahieren
                                            ElevatedButton(
                                          onPressed: hasSelectedOption
                                              ? () {
                                                  context
                                                      .read<
                                                          ShowCorrectOptionCubit>()
                                                      .show();
                                                  final selectedOption = context
                                                      .read<
                                                          OptionSelectionCubit>()
                                                      .state!;
                                                  context
                                                      .read<
                                                          QuestionEvaluationBloc>()
                                                      .add(
                                                        QuestionEvaluationSubmitEvent(
                                                          selectedOption,
                                                        ),
                                                      );
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                colorScheme.secondary,
                                          ),

                                          // ignore: avoid-non-ascii-symbols, TODO add this to i18n
                                          child: const Text('Überprüfen'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const LoadingIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  QuestionsBloc _createQuestionsBloc(BuildContext context) {
    final itemsState = context.read<ItemsBloc>().state as ItemsLoadOnSuccess;
    return QuestionsBloc(
      baseItems: itemsState.baseItems,
      fullItems: itemsState.fullItems,
    )..add(const QuestionsInitializeEvent());
  }
}
