import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/correct_answers/cubit.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/domain/blocs/questions/bloc.dart';
import 'package:tft_guide/static/config.dart';
import 'package:tft_guide/ui/pages/game/body.dart';
import 'package:tft_guide/ui/pages/game/progress_bar.dart';
import 'package:tft_guide/ui/pages/game/quit/button.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/spatula_background.dart';

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
          create: (_) => GameProgressBloc(),
        ),
      ],
      child: BlocBuilder<QuestionsBloc, QuestionsState>(
        builder: (context, state) => switch (state) {
          QuestionsLoadInProgress() => const Scaffold(
              body: LoadingIndicator(),
            ),
          QuestionsLoadOnSuccess(:final questions) => Scaffold(
              appBar: AppBar(
                leading: const QuitButton(),
                title: GameProgressBar(
                  totalQuestion: questions.length,
                ),
                forceMaterialTransparency: true,
              ),
              body: SpatulaBackground(
                child: BlocProvider<CorrectAnswersCubit>(
                  create: (_) => CorrectAnswersCubit(),
                  child: GameBody(questions: questions),
                ),
              ),
            ),
        },
      ),
    );
  }
}
