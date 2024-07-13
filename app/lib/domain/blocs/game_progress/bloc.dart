import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/static/resources/sizes.dart';

part 'event.dart';
part 'state.dart';

final class GameProgressBloc
    extends Bloc<GameProgressEvent, GameProgressState> {
  GameProgressBloc() : super(const GameProgressInProgress(0)) {
    on<GameProgressNextEvent>(_onGameProgressNextEvent);
  }

  void _onGameProgressNextEvent(
    GameProgressNextEvent event,
    Emitter<GameProgressState> emit,
  ) {
    if (state case GameProgressInProgress(:final currentProgress)) {
      final nextProgress = currentProgress + 1;
      final stateToConstruct =
          switch (nextProgress > Sizes.questionsAmount - 1) {
        false => GameProgressInProgress.new,
        true => GameProgressFinished.new,
      };
      final constructedState = Function.apply(
        stateToConstruct,
        [nextProgress],
      ) as GameProgressState;
      emit(constructedState);
    }
  }
}
