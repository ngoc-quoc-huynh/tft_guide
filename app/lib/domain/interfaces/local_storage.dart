abstract interface class LocalStorageApi {
  const LocalStorageApi();

  DateTime? get lastAppUpdate;

  Future<void> updateLastAppUpdate(DateTime date);

  DateTime? get lastRemoteDataUpdate;

  Future<void> updateLastRemoteDataUpdate(DateTime date);

  int get readPatchNotesCount;

  Future<void> updateReadPatchNotesCount(int count);
}
