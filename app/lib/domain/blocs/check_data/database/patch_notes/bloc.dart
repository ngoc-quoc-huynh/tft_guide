part of '../../bloc.dart';

final class CheckPatchNotesBloc extends CheckDatabaseBloc {
  CheckPatchNotesBloc()
      : super(
          className: 'CheckPatchNotesBloc',
          loadLocalDataCount:
              CheckDatabaseBloc.localDatabaseApi.loadPatchNotesCount,
          loadRemoteDataCount:
              CheckDatabaseBloc.remoteDatabaseApi.loadPatchNotesCount,
          loadLocalTranslationCount:
              CheckDatabaseBloc.localDatabaseApi.loadPatchNoteTranslationsCount,
          loadRemoteTranslationCount: CheckDatabaseBloc
              .remoteDatabaseApi.loadPatchNoteTranslationsCount,
        );
}
