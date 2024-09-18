part of 'bloc.dart';

@immutable
sealed class RepairState extends Equatable {
  const RepairState(this.progress);

  final double progress;

  @override
  List<Object?> get props => [progress];
}

final class RepairInitial extends RepairState {
  const RepairInitial() : super(0);
}

sealed class RepairLoadInProgress extends RepairState {
  const RepairLoadInProgress({
    required this.currentStep,
    required this.maxSteps,
    required this.percentageOffset,
  })  : assert(
          percentageOffset >= 0 && percentageOffset <= 100,
          'Percentage offset must be within 0-100.',
        ),
        assert(
          currentStep >= 0 && currentStep <= maxSteps,
          'Current step must be within 0-$maxSteps.',
        ),
        super(
          percentageOffset + (currentStep / maxSteps) * _percentagePerStage,
        );
  final int currentStep;
  final int maxSteps;
  final int percentageOffset;

  static const _totalStages = 2;
  static const _percentagePerStage = 100 / _totalStages;
}

final class RepairLoadRemoteDataInProgress extends RepairLoadInProgress {
  const RepairLoadRemoteDataInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 7,
          percentageOffset: 0,
        );
}

final class RepairSaveDataLocallyInProgress extends RepairLoadInProgress {
  const RepairSaveDataLocallyInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 7,
          percentageOffset: 50,
        );
}

final class RepairAnimationInProgress extends RepairState {
  const RepairAnimationInProgress() : super(100);
}

final class RepairLoadOnSuccess extends RepairState {
  const RepairLoadOnSuccess() : super(100);
}

final class RepairLoadOnFailure extends RepairState {
  const RepairLoadOnFailure(super.progress);
}
