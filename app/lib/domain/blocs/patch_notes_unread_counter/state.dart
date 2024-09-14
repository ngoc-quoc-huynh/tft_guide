part of 'bloc.dart';

@immutable
sealed class PatchNotesUnreadCounterState extends Equatable {
  const PatchNotesUnreadCounterState();

  @override
  List<Object?> get props => [];
}

final class PatchNotesUnreadCounterLoadInProgress
    extends PatchNotesUnreadCounterState {
  const PatchNotesUnreadCounterLoadInProgress();
}

final class PatchNotesUnreadCounterLoadOnSuccess
    extends PatchNotesUnreadCounterState {
  const PatchNotesUnreadCounterLoadOnSuccess({
    required this.unreadCount,
    required this.totalCount,
  });

  final int unreadCount;
  final int totalCount;

  @override
  List<Object?> get props => [unreadCount, totalCount];
}
