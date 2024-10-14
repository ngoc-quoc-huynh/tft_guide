part of 'bloc.dart';

@immutable
sealed class AppUpdateState extends Equatable {
  const AppUpdateState();

  @override
  List<Object?> get props => [];
}

final class AppUpdateInitial extends AppUpdateState {
  const AppUpdateInitial();
}

final class AppUpdateLoadInProgress extends AppUpdateState {
  const AppUpdateLoadInProgress(this.progress);

  final double progress;

  @override
  List<Object?> get props => [progress];
}

final class AppUpdateLoadOnSuccess extends AppUpdateState {
  const AppUpdateLoadOnSuccess(this.path);

  final String path;

  @override
  List<Object?> get props => [path];
}

final class AppUpdateLoadOnFailure extends AppUpdateState {
  const AppUpdateLoadOnFailure();
}
