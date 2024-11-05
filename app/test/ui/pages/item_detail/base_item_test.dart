import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/item_detail/base_item/page.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final localDatabaseApi = MockLocalDatabaseApi();
  final themeApi = MockThemeApi();
  final fileStorageApi = MockFileStorageApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<ThemeApi>(themeApi)
      ..registerSingleton<FileStorageApi>(fileStorageApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<LocalDatabaseApi>()
      ..unregister<ThemeApi>()
      ..unregister<FileStorageApi>(),
  );

  final languageCodeValueCubit = MockLanguageCodeValueCubit();
  whenListen<LanguageCode>(
    languageCodeValueCubit,
    const Stream<LanguageCode>.empty(),
    initialState: LanguageCode.en,
  );

  const itemId = 'id';
  when(() => fileStorageApi.loadFile(itemId)).thenReturn(TestFile.file);

  when(() => localDatabaseApi.loadBaseItemDetail(itemId, LanguageCode.en))
      .thenAnswer(
    (_) async => const BaseItemDetail(
      id: itemId,
      name: 'Name',
      description: 'Description',
      hint: 'Hint',
      abilityPower: 1,
      armor: 2,
      attackDamage: 3,
    ),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'base_item',
    pumpBeforeTest: precacheImages,
    pumpWidget: pumpSingleFrameWidget,
    constraints: pageConstraints(),
    builder: () => _TestWidget(
      languageCodeValueCubit: languageCodeValueCubit,
      mockTheme: (context) => when(
        () => themeApi.computeThemeFromFileImage(
          fileName: itemId,
          brightness: Theme.of(context).brightness,
          textTheme: Theme.of(context).textTheme,
        ),
      ).thenAnswer((_) async => null),
    ),
  );

  await goldenTest(
    'renders theme correctly.',
    fileName: 'base_item_theme',
    pumpBeforeTest: precacheImages,
    pumpWidget: pumpSingleFrameWidget,
    constraints: pageConstraints(),
    builder: () => _TestWidget(
      languageCodeValueCubit: languageCodeValueCubit,
      mockTheme: (context) => when(
        () => themeApi.computeThemeFromFileImage(
          fileName: itemId,
          brightness: Theme.of(context).brightness,
          textTheme: Theme.of(context).textTheme,
        ),
      ).thenAnswer(
        (_) async => ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        ),
      ),
    ),
  );
}

final class _TestWidget extends StatelessWidget {
  const _TestWidget({
    required this.languageCodeValueCubit,
    required this.mockTheme,
  });

  final LanguageCodeValueCubit languageCodeValueCubit;
  final void Function(BuildContext) mockTheme;

  @override
  Widget build(BuildContext context) {
    mockTheme.call(context);
    return BlocProvider<LanguageCodeValueCubit>.value(
      value: languageCodeValueCubit,
      child: BaseItemDetailPage(id: 'id'),
    );
  }
}
