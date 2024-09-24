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
          currentStep >= 0 && currentStep < maxSteps,
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

final class DataSyncInitInProgress extends DataSyncLoadInProgress {
  const DataSyncInitInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 2,
          percentageOffset: 0,
        );
}

final class DataSyncCheckInProgress extends DataSyncLoadInProgress {
  const DataSyncCheckInProgress()
      : super(
          currentStep: 0,
          maxSteps: 1,
          percentageOffset: 20,
        );
}

final class DataSyncLoadLatestUpdatedAtInProgress
    extends DataSyncLoadInProgress {
  const DataSyncLoadLatestUpdatedAtInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 7,
          percentageOffset: 40,
        );
}

final class DataSyncLoadRemoteDataInProgress extends DataSyncLoadInProgress {
  const DataSyncLoadRemoteDataInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 7,
          percentageOffset: 60,
        );
}

final class DataSyncSaveDataLocallyInProgress extends DataSyncLoadInProgress {
  const DataSyncSaveDataLocallyInProgress([int currentStep = 0])
      : super(
          currentStep: currentStep,
          maxSteps: 7,
          percentageOffset: 80,
        );
}

final class DataSyncAnimationInProgress extends DataSyncState {
  const DataSyncAnimationInProgress() : super(100);
}

final class DataSyncLoadOnSuccess extends DataSyncState {
  const DataSyncLoadOnSuccess() : super(100);
}

sealed class DataSyncLoadOnFailure extends DataSyncState {
  const DataSyncLoadOnFailure() : super(100);
}

final class DataSyncInitOnFailure extends DataSyncLoadOnFailure {
  const DataSyncInitOnFailure();
}

final class DataSyncLocalDatabaseOnFailure extends DataSyncLoadOnFailure {
  const DataSyncLocalDatabaseOnFailure();
}

final class DataSyncLoadAndSaveOnFailure extends DataSyncLoadOnFailure {
  const DataSyncLoadAndSaveOnFailure();
}
