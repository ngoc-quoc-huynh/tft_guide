import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/items/bloc.dart';
import 'package:tft_guide/domain/blocs/questions/bloc.dart';
import 'package:tft_guide/ui/widgets/background.dart';

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
            // TODO: Show dialog
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement body
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondary,
              ),

              // ignore: avoid-non-ascii-symbols, TODO add this to i18n
              child: const Text('Überprüfen'),
            ),
          ),
        ),
        body: const Background(
          child: SafeArea(
            child: Text('Test'),
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
