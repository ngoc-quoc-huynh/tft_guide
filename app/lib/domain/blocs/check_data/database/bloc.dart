part of '../bloc.dart';

sealed class CheckDatabaseBloc extends CheckDataBloc {
  CheckDatabaseBloc({
    required this.loadLocalDataCount,
    required this.loadRemoteDataCount,
    required this.loadLocalTranslationCount,
    required this.loadRemoteTranslationCount,
  }) : super(
          () => _compareDataCounts(
            loadLocalDataCount,
            loadRemoteDataCount,
            loadLocalTranslationCount,
            loadRemoteTranslationCount,
          ),
        );

  final Future<int> Function() loadLocalDataCount;
  final Future<int> Function() loadRemoteDataCount;
  final Future<int> Function() loadLocalTranslationCount;
  final Future<int> Function() loadRemoteTranslationCount;

  @protected
  static final localDatabaseApi = Injector.instance.localDatabaseApi;
  @protected
  static final remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  static Future<bool> _compareDataCounts(
    Future<int> Function() loadLocalDataCount,
    Future<int> Function() loadRemoteDataCount,
    Future<int> Function() loadLocalTranslationCount,
    Future<int> Function() loadRemoteTranslationCount,
  ) async {
    final (
      localDataCount,
      remoteDataCount,
      localTranslationCount,
      remoteTranslationCount,
    ) = await (
      loadLocalDataCount(),
      loadRemoteDataCount(),
      loadLocalTranslationCount(),
      loadRemoteTranslationCount(),
    ).wait;
    return localDataCount == remoteDataCount &&
        localTranslationCount == remoteTranslationCount;
  }
}
