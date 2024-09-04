part of 'bloc.dart';

@immutable
sealed class DataSyncState extends Equatable {
  const DataSyncState(this.progress);

  final double progress;

  @override
  List<Object?> get props => [progress];
}

sealed class DataSyncLoadInProgress extends DataSyncState {
  const DataSyncLoadInProgress({
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

  static const _totalStages = 5;
  static const _percentagePerStage = 100 / _totalStages;
}

final class DataSyncCheckInProgress extends DataSyncLoadInProgress {
  const DataSyncCheckInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 1,
          percentageOffset: 0,
        );
}

final class DataSyncInitInProgress extends DataSyncLoadInProgress {
  const DataSyncInitInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 2,
          percentageOffset: 20,
        );
}

final class DataSyncLoadLatestUpdatedAtInProgress
    extends DataSyncLoadInProgress {
  const DataSyncLoadLatestUpdatedAtInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 5,
          percentageOffset: 40,
        );
}

final class DataSyncLoadRemoteDataInProgress extends DataSyncLoadInProgress {
  const DataSyncLoadRemoteDataInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 5,
          percentageOffset: 60,
        );
}

final class DataSyncStoreDataLocallyInProgress extends DataSyncLoadInProgress {
  const DataSyncStoreDataLocallyInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 5,
          percentageOffset: 80,
        );
}

final class DataSyncLoadOnSuccess extends DataSyncState {
  const DataSyncLoadOnSuccess() : super(100);
}
