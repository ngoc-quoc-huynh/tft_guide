part of '../bloc.dart';

sealed class CheckDatabaseBloc extends CheckDataBloc {
  CheckDatabaseBloc({
    required String className,
    required this.loadLocalDataCount,
    required this.loadRemoteDataCount,
    required this.loadLocalTranslationCount,
    required this.loadRemoteTranslationCount,
  }) : super(
          className,
          () => _compute(
            loadLocalDataCount: loadLocalDataCount,
            loadRemoteDataCount: loadRemoteDataCount,
            loadLocalTranslationCount: loadLocalTranslationCount,
            loadRemoteTranslationCount: loadRemoteTranslationCount,
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

  static Future<CheckDataLoadOnSuccess> _compute({
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
    return switch (isValid) {
      false => CheckDatabaseLoadOnInvalid(
          localDataCount: localDataCount,
          remoteDataCount: remoteDataCount,
          localTranslationCount: localTranslationCount,
          remoteTranslationCount: remoteTranslationCount,
        ),
      true => CheckDatabaseLoadOnValid(
          localDataCount: localDataCount,
          remoteDataCount: remoteDataCount,
          localTranslationCount: localTranslationCount,
          remoteTranslationCount: remoteTranslationCount,
        ),
    };
  }
}
