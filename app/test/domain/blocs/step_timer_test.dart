import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/step_timer/cubit.dart';

void main() {
  test(
    'initial state is StepTimerInitial.',
    () => expect(
      StepTimerCubit(1).state,
      const StepTimerInitial(),
    ),
  );

  group('advance', () {
    blocTest<StepTimerCubit, StepTimerState>(
      'emits StepTimerCompleted when state was StepTimerInitial and max steps '
      'is reached.',
      build: () => StepTimerCubit(1),
      act: (cubit) => cubit.advance(),
      expect: () => const [
        StepTimerCompleted(),
        StepTimerInitial(),
      ],
    );

    blocTest<StepTimerCubit, StepTimerState>(
      'emits StepTimerInProgress when state was StepTimerInitial and max steps '
      'is not reached.',
      build: () => StepTimerCubit(2),
      act: (cubit) => cubit.advance(),
      expect: () => const [StepTimerInProgress(1)],
    );

    blocTest<StepTimerCubit, StepTimerState>(
      'emits StepTimerCompleted when state was StepTimerInProgress and max '
      'steps is reached.',
      build: () => StepTimerCubit(2),
      seed: () => const StepTimerInProgress(1),
      act: (cubit) => cubit.advance(),
      expect: () => const [
        StepTimerCompleted(),
        StepTimerInitial(),
      ],
    );

    blocTest<StepTimerCubit, StepTimerState>(
      'emits StepTimerInProgress when state was StepTimerInProgress and max '
      'steps is not reached.',
      build: () => StepTimerCubit(3),
      seed: () => const StepTimerInProgress(1),
      act: (cubit) => cubit.advance(),
      expect: () => const [StepTimerInProgress(2)],
    );

    blocTest<StepTimerCubit, StepTimerState>(
      'emits StepTimerInitial when timer is finished.',
      build: () => StepTimerCubit(2),
      act: (cubit) => cubit.advance(),
      wait: const Duration(seconds: 1),
      expect: () => const [
        StepTimerInProgress(1),
        StepTimerInitial(),
      ],
    );
  });
}
