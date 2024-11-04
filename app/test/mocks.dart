import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tft_guide/domain/blocs/app_update_info/cubit.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/rank/bloc.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/interfaces/admin.dart';
import 'package:tft_guide/domain/interfaces/app.dart';
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
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';

final class MockAdminApi extends Mock implements AdminApi {}

final class MockAppApi extends Mock implements AppApi {}

final class MockDirectory extends Mock implements Directory {}

final class MockFeedbackApi extends Mock implements FeedbackApi {}

final class MockFileStorageApi extends Mock implements FileStorageApi {}

final class MockLocalDatabaseApi extends Mock implements LocalDatabaseApi {}

final class MockLocalStorageApi extends Mock implements LocalStorageApi {}

final class MockLogger extends Mock implements Logger {}

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

final class MockAppUpdateInfoCubit extends MockCubit<AppUpdateInfo?>
    with TestAppUpdateInfoCubitMixin {}

final class MockDataSyncBloc extends MockBloc<DataSyncEvent, DataSyncState>
    with TestDataSyncBlocMixin {}

final class MockHydratedEloCubit extends MockCubit<int>
    with TestHydratedEloCubitMixin {}

final class MockHydratedThemeModeCubit extends MockCubit<ThemeMode>
    with TestHydratedThemeModeCubitMixin {}

final class MockHydratedTranslationLocaleCubit
    extends MockCubit<TranslationLocale>
    with TestHydratedTranslationLocaleCubitMixin {}

final class MockLanguageCodeValueCubit extends MockCubit<LanguageCode>
    with TestLanguageCodeValueCubitMixin {}

final class MockNumValueCubit<State extends num?> extends MockCubit<State>
    with TestNumValueCubit<State> {}

final class MockRankCubit extends MockCubit<RankState>
    with TestRankCubitMixin {}

final class MockValueCubit<State> extends MockCubit<State>
    with TestValueCubitMixin<State> {}
