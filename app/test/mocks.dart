import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';

final class MockFileStorageApi extends Mock implements FileStorageApi {}

final class MockLocalDatabaseApi extends Mock implements LocalDatabaseApi {}

final class MockRemoteDatabaseApi extends Mock implements RemoteDatabaseApi {}

final class MockLocalStorageApi extends Mock implements LocalStorageApi {}

final class MockThemeApi extends Mock implements ThemeApi {}
