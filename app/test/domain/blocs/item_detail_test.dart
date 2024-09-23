import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/item_detail/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/theme.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final localDatabaseApi = MockLocalDatabaseApi();
  final themeApi = MockThemeApi();
  final themeData = ThemeData(brightness: Brightness.dark);

  setUpAll(
    () => Injector.instance
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<ThemeApi>(themeApi)
      ..registerSingleton<Translations>(TranslationsEn.build()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<LocalDatabaseApi>()
      ..unregister<ThemeApi>()
      ..unregister<Translations>(),
  );

  group('BaseItemDetailBloc', () {
    const item = BaseItemDetail(
      id: 'id',
      name: 'name',
      description: 'description',
      hint: 'hint',
    );

    test(
      'initial state is BaseItemDetailLoadInProgress.',
      () => expect(
        BaseItemDetailBloc().state,
        const ItemDetailLoadInProgress(),
      ),
    );

    group('ItemDetailInitializeEvent', () {
      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnSuccess.',
        setUp: () {
          when(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          ).thenAnswer((_) async => item);
          when(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.dark,
              textTheme: const TextTheme(),
            ),
          ).thenAnswer((_) async => themeData);
        },
        build: BaseItemDetailBloc.new,
        act: (bloc) => bloc.add(
          const ItemDetailInitializeEvent(
            id: 'id',
            brightness: Brightness.dark,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => [
          ItemDetailLoadOnSuccess<BaseItemDetail>(
            item: item,
            themeData: themeData,
          ),
        ],
        verify: (_) {
          verifyInOrder([
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
            () => themeApi.computeThemeFromFileImage(
                  fileName: 'id',
                  brightness: Brightness.dark,
                  textTheme: const TextTheme(),
                ),
          ]);
        },
      );

      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnFailure when an error occurs.',
        setUp: () => when(
          () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
        ).thenThrow(const UnknownException()),
        build: BaseItemDetailBloc.new,
        act: (bloc) => bloc.add(
          const ItemDetailInitializeEvent(
            id: 'id',
            brightness: Brightness.dark,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => const [ItemDetailLoadOnFailure()],
        verify: (_) {
          verify(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          ).called(1);
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.dark,
              textTheme: const TextTheme(),
            ),
          );
        },
      );
    });

    group('ItemDetailUpdateThemeDataEvent', () {
      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnSuccess.',
        setUp: () => when(
          () => themeApi.computeThemeFromFileImage(
            fileName: 'id',
            brightness: Brightness.light,
            textTheme: const TextTheme(),
          ),
        ).thenAnswer(
          (_) async => themeData.copyWith(brightness: Brightness.light),
        ),
        build: BaseItemDetailBloc.new,
        seed: () => ItemDetailLoadOnSuccess<BaseItemDetail>(
          item: item,
          themeData: themeData,
        ),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateThemeDataEvent(
            brightness: Brightness.light,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => [
          const ItemDetailLoadInProgress(),
          ItemDetailLoadOnSuccess<BaseItemDetail>(
            item: item,
            themeData: themeData.copyWith(brightness: Brightness.light),
          ),
        ],
        verify: (_) {
          verify(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          ).called(1);
          verifyNever(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          );
        },
      );

      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits nothing when state was not ItemDetailLoadOnSuccess.',
        build: BaseItemDetailBloc.new,
        seed: () => const ItemDetailLoadInProgress(),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateThemeDataEvent(
            brightness: Brightness.light,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => const <ItemDetailState>[],
        verify: (_) {
          verifyNever(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          );
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );
    });

    group('ItemDetailUpdateLanguageCodeEvent', () {
      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnSuccess.',
        setUp: () => when(
          () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
        ).thenAnswer((_) async => item),
        build: BaseItemDetailBloc.new,
        seed: () => ItemDetailLoadOnSuccess<BaseItemDetail>(
          item: item,
          themeData: themeData,
        ),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateLanguageCodeEvent(
            LanguageCode.en,
          ),
        ),
        expect: () => [
          const ItemDetailLoadInProgress(),
          ItemDetailLoadOnSuccess<BaseItemDetail>(
            item: item,
            themeData: themeData,
          ),
        ],
        verify: (_) {
          verify(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          ).called(1);
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );

      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits nothing when state was not ItemDetailLoadOnSuccess.',
        build: BaseItemDetailBloc.new,
        seed: () => const ItemDetailLoadInProgress(),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateLanguageCodeEvent(
            LanguageCode.en,
          ),
        ),
        expect: () => const <ItemDetailState>[],
        verify: (_) {
          verifyNever(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          );
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );

      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnFailure when an error occurs.',
        setUp: () => when(
          () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
        ).thenThrow(const UnknownException()),
        build: BaseItemDetailBloc.new,
        seed: () => ItemDetailLoadOnSuccess<BaseItemDetail>(
          item: item,
          themeData: themeData,
        ),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateLanguageCodeEvent(
            LanguageCode.en,
          ),
        ),
        expect: () => const [
          ItemDetailLoadInProgress(),
          ItemDetailLoadOnFailure(),
        ],
        verify: (_) {
          verify(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          ).called(1);
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );
    });
  });

  group('FullItemDetailBloc', () {
    const item = FullItemDetail(
      id: 'id',
      name: 'name',
      description: 'description',
      hint: 'hint',
      itemId1: 'itemId1',
      itemId2: 'itemId2',
    );

    test(
      'initial state is BaseItemDetailLoadInProgress.',
      () =>
          expect(FullItemDetailBloc().state, const ItemDetailLoadInProgress()),
    );

    group('ItemDetailInitializeEvent', () {
      blocTest<FullItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnSuccess.',
        setUp: () {
          when(
            () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
          ).thenAnswer((_) async => item);
          when(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.dark,
              textTheme: const TextTheme(),
            ),
          ).thenAnswer((_) async => themeData);
        },
        build: FullItemDetailBloc.new,
        act: (bloc) => bloc.add(
          const ItemDetailInitializeEvent(
            id: 'id',
            brightness: Brightness.dark,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => [
          ItemDetailLoadOnSuccess<FullItemDetail>(
            item: item,
            themeData: themeData,
          ),
        ],
        verify: (_) {
          verifyInOrder([
            () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
            () => themeApi.computeThemeFromFileImage(
                  fileName: 'id',
                  brightness: Brightness.dark,
                  textTheme: const TextTheme(),
                ),
          ]);
        },
      );

      blocTest<FullItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnFailure when an error occurs.',
        setUp: () => when(
          () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
        ).thenThrow(const UnknownException()),
        build: FullItemDetailBloc.new,
        act: (bloc) => bloc.add(
          const ItemDetailInitializeEvent(
            id: 'id',
            brightness: Brightness.dark,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => const [
          ItemDetailLoadOnFailure(),
        ],
        verify: (_) {
          verify(
            () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
          ).called(1);
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.dark,
              textTheme: const TextTheme(),
            ),
          );
        },
      );
    });

    group('ItemDetailUpdateThemeDataEvent', () {
      blocTest<FullItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnSuccess.',
        setUp: () => when(
          () => themeApi.computeThemeFromFileImage(
            fileName: 'id',
            brightness: Brightness.light,
            textTheme: const TextTheme(),
          ),
        ).thenAnswer(
          (_) async => themeData.copyWith(brightness: Brightness.light),
        ),
        build: FullItemDetailBloc.new,
        seed: () => ItemDetailLoadOnSuccess<FullItemDetail>(
          item: item,
          themeData: themeData,
        ),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateThemeDataEvent(
            brightness: Brightness.light,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => [
          const ItemDetailLoadInProgress(),
          ItemDetailLoadOnSuccess<FullItemDetail>(
            item: item,
            themeData: themeData.copyWith(brightness: Brightness.light),
          ),
        ],
        verify: (_) {
          verify(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          ).called(1);
          verifyNever(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          );
        },
      );

      blocTest<BaseItemDetailBloc, ItemDetailState>(
        'emits nothing when state was not ItemDetailLoadOnSuccess.',
        build: BaseItemDetailBloc.new,
        seed: () => const ItemDetailLoadInProgress(),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateThemeDataEvent(
            brightness: Brightness.light,
            textTheme: TextTheme(),
          ),
        ),
        expect: () => const <ItemDetailState>[],
        verify: (_) {
          verifyNever(
            () => localDatabaseApi.loadBaseItemDetail('id', LanguageCode.en),
          );
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );
    });

    group('ItemDetailUpdateLanguageCodeEvent', () {
      blocTest<FullItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnSuccess.',
        setUp: () => when(
          () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
        ).thenAnswer((_) async => item),
        build: FullItemDetailBloc.new,
        seed: () => ItemDetailLoadOnSuccess<FullItemDetail>(
          item: item,
          themeData: themeData,
        ),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateLanguageCodeEvent(
            LanguageCode.en,
          ),
        ),
        expect: () => [
          const ItemDetailLoadInProgress(),
          ItemDetailLoadOnSuccess<FullItemDetail>(
            item: item,
            themeData: themeData,
          ),
        ],
        verify: (_) {
          verify(
            () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
          ).called(1);
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );

      blocTest<FullItemDetailBloc, ItemDetailState>(
        'emits nothing when state was not ItemDetailLoadOnSuccess.',
        build: FullItemDetailBloc.new,
        seed: () => const ItemDetailLoadInProgress(),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateLanguageCodeEvent(
            LanguageCode.en,
          ),
        ),
        expect: () => const <ItemDetailState>[],
        verify: (_) {
          verifyNever(
            () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
          );
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );

      blocTest<FullItemDetailBloc, ItemDetailState>(
        'emits ItemDetailLoadOnFailure when an error occurs.',
        setUp: () => when(
          () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
        ).thenThrow(const UnknownException()),
        build: FullItemDetailBloc.new,
        seed: () => ItemDetailLoadOnSuccess<FullItemDetail>(
          item: item,
          themeData: themeData,
        ),
        act: (bloc) => bloc.add(
          const ItemDetailUpdateLanguageCodeEvent(
            LanguageCode.en,
          ),
        ),
        expect: () => const [
          ItemDetailLoadInProgress(),
          ItemDetailLoadOnFailure(),
        ],
        verify: (_) {
          verify(
            () => localDatabaseApi.loadFullItemDetail('id', LanguageCode.en),
          ).called(1);
          verifyNever(
            () => themeApi.computeThemeFromFileImage(
              fileName: 'id',
              brightness: Brightness.light,
              textTheme: const TextTheme(),
            ),
          );
        },
      );
    });
  });
}
