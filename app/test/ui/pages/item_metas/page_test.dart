import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/item_metas/page.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final localDatabaseApi = MockLocalDatabaseApi();
  final fileStorageApi = MockFileStorageApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<FileStorageApi>(fileStorageApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<LocalDatabaseApi>(),
  );

  final languageCodeValueCubit = MockLanguageCodeValueCubit();
  whenListen<LanguageCode>(
    languageCodeValueCubit,
    const Stream<LanguageCode>.empty(),
    initialState: LanguageCode.en,
  );

  when(() => fileStorageApi.loadFile(any())).thenReturn(TestFile.file);

  await goldenTest(
    'renders empty correctly.',
    fileName: 'page_empty',
    constraints: pageConstraints(),
    builder: () {
      when(() => localDatabaseApi.loadBaseItemMetas(LanguageCode.en))
          .thenAnswer((_) async => []);
      when(() => localDatabaseApi.loadFullItemMetas(LanguageCode.en))
          .thenAnswer((_) async => []);
      return _TestWidget(languageCodeValueCubit);
    },
  );

  await goldenTest(
    'renders filled correctly.',
    fileName: 'page_filled',
    pumpBeforeTest: precacheImages,
    pumpWidget: pumpSingleFrameWidget,
    constraints: pageConstraints(),
    builder: () {
      when(() => localDatabaseApi.loadBaseItemMetas(LanguageCode.en))
          .thenAnswer(
        (_) async => [
          const BaseItemMeta(
            id: 'base-item',
            name: 'Base Item',
          ),
        ],
      );
      when(() => localDatabaseApi.loadFullItemMetas(LanguageCode.en))
          .thenAnswer(
        (_) async => [
          const FullItemMeta(
            id: 'full-item',
            name: 'Full Item',
          ),
        ],
      );
      return _TestWidget(languageCodeValueCubit);
    },
  );

  await goldenTest(
    'renders error correctly.',
    fileName: 'page_error',
    constraints: pageConstraints(),
    builder: () {
      when(() => localDatabaseApi.loadBaseItemMetas(LanguageCode.en))
          .thenThrow(const UnknownException());

      return _TestWidget(languageCodeValueCubit);
    },
  );
}

class _TestWidget extends StatelessWidget {
  const _TestWidget(this.languageCodeValueCubit);

  final LanguageCodeValueCubit languageCodeValueCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCodeValueCubit>.value(
      value: languageCodeValueCubit,
      child: const ItemMetasPage(),
    );
  }
}
