import 'package:tft_guide/infrastructure/repositories/sqlite_async.dart';

final class MockLocalDatabaseApi extends SqliteAsyncRepository {
  MockLocalDatabaseApi();

  @override
  Future<void> close() => Future.value();
}
