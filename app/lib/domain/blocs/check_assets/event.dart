part of 'bloc.dart';

@immutable
sealed class CheckAssetsEvent {
  const CheckAssetsEvent();
}

final class CheckAssetsStartEvent extends CheckAssetsEvent {
  const CheckAssetsStartEvent();
}
