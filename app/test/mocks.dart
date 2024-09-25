import 'dart:io';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/domain/interfaces/feedback.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/domain/interfaces/native.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';

final class MockDirectory extends Mock implements Directory {}

final class MockFeedbackApi extends Mock implements FeedbackApi {}

final class MockFileStorageApi extends Mock implements FileStorageApi {}

final class MockLocalDatabaseApi extends Mock implements LocalDatabaseApi {}

final class MockLocalStorageApi extends Mock implements LocalStorageApi {}

final class MockLoggerApi extends Mock implements LoggerApi {}

final class MockNativeApi extends Mock implements NativeApi {}

// ignore: avoid_implementing_value_types, for testing purpose.
final class MockPackageInfo extends Mock implements PackageInfo {}

final class MockRankApi extends Mock implements RankApi {}

final class MockRemoteDatabaseApi extends Mock implements RemoteDatabaseApi {}

final class MockSharedPreferencesWithCache extends Mock
    implements SharedPreferencesWithCache {}

final class MockThemeApi extends Mock implements ThemeApi {}

final class MockStorage extends Mock implements Storage {}

final class MockWidgetsBindingApi extends Mock implements WidgetsBindingApi {}
