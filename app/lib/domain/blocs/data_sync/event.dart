part of 'bloc.dart';

@immutable
sealed class DataSyncEvent {
  const DataSyncEvent();
}

final class DataSyncInitializeEvent extends DataSyncEvent {
  const DataSyncInitializeEvent();
}
