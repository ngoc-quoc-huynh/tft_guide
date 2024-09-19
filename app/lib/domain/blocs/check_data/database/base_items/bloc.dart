part of '../../bloc.dart';

final class CheckBaseItemsBloc extends CheckDatabaseBloc {
  CheckBaseItemsBloc()
      : super(
          className: 'CheckBaseItemsBloc',
          loadLocalDataCount:
              CheckDatabaseBloc.localDatabaseApi.loadBaseItemsCount,
          loadRemoteDataCount:
              CheckDatabaseBloc.remoteDatabaseApi.loadBaseItemsCount,
          loadLocalTranslationCount:
              CheckDatabaseBloc.localDatabaseApi.loadBaseItemTranslationsCount,
          loadRemoteTranslationCount:
              CheckDatabaseBloc.remoteDatabaseApi.loadBaseItemTranslationsCount,
        );
}
