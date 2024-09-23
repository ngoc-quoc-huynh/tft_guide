import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/game_progress/bloc.dart';

void main() {
  test(
    'initial state is GameProgressInProgress',
    () => expect(GameProgressBloc(2).state, const GameProgressInProgress(0)),
  );

  group('GameProgressNextEvent', () {
    blocTest<GameProgressBloc, GameProgressState>(
      'emits GameProgressInProgress.',
      build: () => GameProgressBloc(2),
      act: (bloc) => bloc.add(const GameProgressNextEvent()),
      expect: () => [const GameProgressInProgress(1)],
    );

    blocTest<GameProgressBloc, GameProgressState>(
      'emits GameProgressFinished when next level is the last level.',
      build: () => GameProgressBloc(2),
      seed: () => const GameProgressInProgress(1),
      act: (bloc) => bloc.add(const GameProgressNextEvent()),
      expect: () => [const GameProgressFinished(2)],
    );
  });
}
