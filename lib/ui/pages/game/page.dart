import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';
import 'package:tft_guide/ui/pages/game/feedback.dart';
import 'package:tft_guide/ui/pages/game/progress_bar.dart';
import 'package:tft_guide/ui/pages/game/quit_button.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  static const routeName = 'game';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameProgressBloc>(
      create: (_) => GameProgressBloc(),
      child: Scaffold(
        body: AppBar(
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
      ),
    );
  }
}
