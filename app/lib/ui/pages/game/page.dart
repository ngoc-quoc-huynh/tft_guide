import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/blocs/questions/bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/question/question.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/config.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/game/body.dart';
import 'package:tft_guide/ui/pages/game/progress_bar.dart';
import 'package:tft_guide/ui/pages/game/quit/button.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/error_text.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuestionsBloc>(
          create: (_) => QuestionsBloc(
            totalBaseItemQuestions: Config.totalBaseItemQuestions,
            totalFullItemQuestions: Config.totalFullItemQuestions,
          )..add(const QuestionsInitializeEvent()),
        ),
        BlocProvider<GameProgressBloc>(
          create: (_) => GameProgressBloc(
            Config.totalBaseItemQuestions + Config.totalFullItemQuestions,
          ),
        ),
      ],
      child: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) => switch (state) {
          QuestionsLoadInProgress() => const CustomScaffold(
              appBar: CustomAppBar(),
              body: LoadingIndicator(),
            ),
          QuestionsLoadOnFailure() => const _Error(),
          QuestionsLoadOnSuccess(:final questions) => _Success(questions),
        },
      ),
    );
  }
}

class _Success extends StatelessWidget {
  const _Success(this.questions);

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        leading: const QuitButton(),
        title: GameProgressBar(
          totalQuestion: questions.length,
        ),
      ),
      body: BlocProvider<CorrectAnswersCubit>(
        create: (_) => CorrectAnswersCubit(0),
        child: GameBody(questions: questions),
      ),
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        child: Center(
          child: ErrorText(
            text: Injector.instance.translations.pages.game.errors.questions,
          ),
        ),
      ),
    );
  }
}
