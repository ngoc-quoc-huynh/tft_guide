part of '../bloc.dart';

final class CheckAssetsBloc extends CheckDataBloc {
  CheckAssetsBloc()
      : super(
          'CheckAssetsBloc',
          _compute,
        );

  static final _fileStorageApi = Injector.instance.fileStorageApi;
  static final _remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  static Future<CheckDataLoadOnSuccess> _compute() async {
    final localCount = _fileStorageApi.loadAssetsCount();
    final remoteCount = await _remoteDatabaseApi.loadAssetsCount();

    if (localCount == remoteCount) {
      return CheckAssetsLoadOnValid(
        localCount: localCount,
        remoteCount: remoteCount,
      );
    } else {
      return CheckAssetsLoadOnInvalid(
        localCount: localCount,
        remoteCount: remoteCount,
      );
    }
  }
}
