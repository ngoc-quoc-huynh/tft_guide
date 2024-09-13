part of '../../bloc.dart';

final class CheckFullItemsBloc extends CheckDatabaseBloc {
  CheckFullItemsBloc()
      : super(
          loadLocalDataCount:
              CheckDatabaseBloc.localDatabaseApi.loadFullItemsCount,
          loadRemoteDataCount:
              CheckDatabaseBloc.remoteDatabaseApi.loadFullItemsCount,
          loadLocalTranslationCount:
              CheckDatabaseBloc.localDatabaseApi.loadFullItemTranslationsCount,
          loadRemoteTranslationCount:
              CheckDatabaseBloc.remoteDatabaseApi.loadFullItemTranslationsCount,
        );
}
