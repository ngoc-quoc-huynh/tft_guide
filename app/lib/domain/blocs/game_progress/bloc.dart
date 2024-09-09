import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

final class GameProgressBloc
    extends Bloc<GameProgressEvent, GameProgressState> {
  GameProgressBloc(this._maxLevels) : super(const GameProgressInProgress(0)) {
    on<GameProgressNextEvent>(_onGameProgressNextEvent);
  }

  final int _maxLevels;

  void _onGameProgressNextEvent(
    GameProgressNextEvent event,
    Emitter<GameProgressState> emit,
  ) {
    if (state case GameProgressInProgress(:final currentProgress)) {
      final nextProgress = currentProgress + 1;
      final stateToConstruct = switch (nextProgress > _maxLevels - 1) {
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
