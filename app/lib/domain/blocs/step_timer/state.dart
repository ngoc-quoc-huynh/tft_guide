part of 'cubit.dart';

@immutable
sealed class StepTimerState extends Equatable {
  const StepTimerState();

  @override
  List<Object?> get props => [];
}

final class StepTimerInitial extends StepTimerState {
  const StepTimerInitial();
}

final class StepTimerInProgress extends StepTimerState {
  const StepTimerInProgress(this.step);

  final int step;

  @override
  List<Object?> get props => [step];
}

final class StepTimerCompleted extends StepTimerState {
  const StepTimerCompleted();
}
