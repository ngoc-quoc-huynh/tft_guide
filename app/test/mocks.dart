import 'dart:math';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';

final class MockFileStorageApi extends Mock implements FileStorageApi {}

final class MockLocalDatabaseApi extends Mock implements LocalDatabaseApi {}

final class MockRemoteDatabaseApi extends Mock implements RemoteDatabaseApi {}

final class MockLocalStorageApi extends Mock implements LocalStorageApi {}

class MockRandom implements Random {
  MockRandom() : _random = Random(0);
  final Random _random;

  @override
  bool nextBool() => _random.nextBool();

  @override
  double nextDouble() => _random.nextDouble();

  @override
  int nextInt(int max) => _random.nextInt(max);
}

final class MockRankApi extends Mock implements RankApi {}

final class MockThemeApi extends Mock implements ThemeApi {}

final class MockStorage extends Mock implements Storage {}
