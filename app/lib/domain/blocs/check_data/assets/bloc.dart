part of '../bloc.dart';

final class CheckAssetsBloc extends CheckDataBloc {
  CheckAssetsBloc() : super(_compareFileCounts);

  static final _fileStorageApi = Injector.instance.fileStorageApi;
  static final _remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  static Future<bool> _compareFileCounts() async {
    final localCount = _fileStorageApi.loadAssetsCount();
    final remoteCount = await _remoteDatabaseApi.loadAssetsCount();
    return localCount == remoteCount;
  }
}
