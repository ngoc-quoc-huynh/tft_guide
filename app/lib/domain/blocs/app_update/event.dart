part of 'bloc.dart';

@immutable
sealed class AppUpdateEvent {
  const AppUpdateEvent();
}

final class AppUpdateInitializeEvent extends AppUpdateEvent {
  const AppUpdateInitializeEvent();
}
