part of '../bloc.dart';

sealed class CheckDatabaseBloc extends CheckDataBloc {
  CheckDatabaseBloc({
    required this.loadLocalDataCount,
    required this.loadRemoteDataCount,
    required this.loadLocalTranslationCount,
    required this.loadRemoteTranslationCount,
  }) : super(
          () => _computeSuccessState(
            loadLocalDataCount: loadLocalDataCount,
            loadRemoteDataCount: loadRemoteDataCount,
            loadLocalTranslationCount: loadLocalTranslationCount,
            loadRemoteTranslationCount: loadRemoteTranslationCount,
          ),
        );

  static Future<CheckDataLoadOnSuccess> _computeSuccessState({
    required Future<int> Function() loadLocalDataCount,
    required Future<int> Function() loadRemoteDataCount,
    required Future<int> Function() loadLocalTranslationCount,
    required Future<int> Function() loadRemoteTranslationCount,
  }) async {
    final [
      localDataCount,
      remoteDataCount,
      localTranslationCount,
      remoteTranslationCount,
    ] = await Future.wait<int>(
      [
        loadLocalDataCount(),
        loadRemoteDataCount(),
        loadLocalTranslationCount(),
        loadRemoteTranslationCount(),
      ],
      eagerError: true,
    );
    final isValid = localDataCount == remoteDataCount &&
        localTranslationCount == remoteTranslationCount;
    if (isValid) {
      return CheckDatabaseLoadOnValid(
        localDataCount: localDataCount,
        remoteDataCount: remoteDataCount,
        localTranslationCount: localTranslationCount,
        remoteTranslationCount: remoteTranslationCount,
      );
    } else {
      return CheckDatabaseLoadOnInvalid(
        localDataCount: localDataCount,
        remoteDataCount: remoteDataCount,
        localTranslationCount: localTranslationCount,
        remoteTranslationCount: remoteTranslationCount,
      );
    }
  }

  final Future<int> Function() loadLocalDataCount;
  final Future<int> Function() loadRemoteDataCount;
  final Future<int> Function() loadLocalTranslationCount;
  final Future<int> Function() loadRemoteTranslationCount;

  @protected
  static final localDatabaseApi = Injector.instance.localDatabaseApi;
  @protected
  static final remoteDatabaseApi = Injector.instance.remoteDatabaseApi;
}
