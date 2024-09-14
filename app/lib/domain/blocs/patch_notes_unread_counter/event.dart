part of 'bloc.dart';

@immutable
sealed class PatchNotesUnreadCounterEvent {
  const PatchNotesUnreadCounterEvent();
}

final class PatchNotesUnreadCounterInitializeEvent
    extends PatchNotesUnreadCounterEvent {
  const PatchNotesUnreadCounterInitializeEvent();
}

final class PatchNotesUnreadCounterReadEvent
    extends PatchNotesUnreadCounterEvent {
  const PatchNotesUnreadCounterReadEvent();
}
