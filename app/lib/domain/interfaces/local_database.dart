abstract interface class LocalDatabaseAPI {
  const LocalDatabaseAPI();

  Future<LocalDatabaseAPI> initialize();

  Future<void> close();
}
