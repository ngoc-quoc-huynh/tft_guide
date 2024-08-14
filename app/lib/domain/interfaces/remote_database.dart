abstract interface class RemoteDatabaseAPI {
  const RemoteDatabaseAPI();

  Future<RemoteDatabaseAPI> initialize();

  Future<List<String>> loadUpdatedAssets(DateTime? lastUpdated);
}
