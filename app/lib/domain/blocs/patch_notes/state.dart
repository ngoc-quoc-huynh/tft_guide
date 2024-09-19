part of 'bloc.dart';

@immutable
sealed class PatchNotesState extends Equatable {
  const PatchNotesState();

  @override
  List<Object?> get props => [];
}

final class PatchNotesLoadInProgress extends PatchNotesState {
  const PatchNotesLoadInProgress();
}

sealed class PatchNotesLoadOnSuccess extends PatchNotesState {
  const PatchNotesLoadOnSuccess({
    required this.currentPage,
    required this.patchNotes,
    required this.isLastPage,
  });

  final List<PatchNote> patchNotes;
  final int currentPage;
  final bool isLastPage;

  @override
  List<Object?> get props => [
        patchNotes,
        currentPage,
        isLastPage,
      ];
}

final class PatchNotesPaginationInProgress extends PatchNotesLoadOnSuccess {
  const PatchNotesPaginationInProgress({
    required super.currentPage,
    required super.patchNotes,
    required super.isLastPage,
  });
}

final class PatchNotesChangeLocaleOnSuccess extends PatchNotesLoadOnSuccess {
  const PatchNotesChangeLocaleOnSuccess({
    required super.currentPage,
    required super.patchNotes,
    required super.isLastPage,
  });
}

final class PatchNotesPaginationOnSuccess extends PatchNotesLoadOnSuccess {
  const PatchNotesPaginationOnSuccess({
    required super.currentPage,
    required super.patchNotes,
    required super.isLastPage,
  });
}

final class PatchNotesPaginationOnFailure extends PatchNotesLoadOnSuccess {
  const PatchNotesPaginationOnFailure({
    required super.currentPage,
    required super.patchNotes,
    required super.isLastPage,
  });
}

final class PatchNotesLoadOnFailure extends PatchNotesState {
  const PatchNotesLoadOnFailure();
}
