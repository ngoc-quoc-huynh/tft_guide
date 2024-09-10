part of 'bloc.dart';

@immutable
sealed class PatchNotesEvent {
  const PatchNotesEvent();
}

final class PatchNotesInitializeEvent extends PatchNotesEvent {
  const PatchNotesInitializeEvent();
}

final class PatchNotesLoadMoreEvent extends PatchNotesEvent {
  const PatchNotesLoadMoreEvent();
}

final class PatchNotesChangeLanguageEvent extends PatchNotesEvent {
  const PatchNotesChangeLanguageEvent(this.languageCode);

  final LanguageCode languageCode;
}
