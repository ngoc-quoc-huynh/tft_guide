import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/item_metas/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final localDatabaseApi = MockLocalDatabaseApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<Translations>(TranslationsEn.build()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<LocalDatabaseApi>()
      ..unregister<Translations>(),
  );

  test(
    'initial state is ItemMetasLoadInProgress.',
    () => expect(
      ItemMetasBloc().state,
      const ItemMetasLoadInProgress(),
    ),
  );

  group('ItemMetasInitializeEvent', () {
    blocTest<ItemMetasBloc, ItemMetasState>(
      'emits ItemMetasLoadOnSuccess.',
      setUp: () {
        when(() => localDatabaseApi.loadBaseItemMetas(LanguageCode.en))
            .thenAnswer(
          (_) async => [],
        );
        when(() => localDatabaseApi.loadFullItemMetas(LanguageCode.en))
            .thenAnswer(
          (_) async => [],
        );
      },
      build: ItemMetasBloc.new,
      act: (bloc) => bloc.add(const ItemMetasInitializeEvent()),
      expect: () => const [ItemMetasLoadOnSuccess([])],
      verify: (_) => verifyInOrder([
        () => localDatabaseApi.loadBaseItemMetas(LanguageCode.en),
        () => localDatabaseApi.loadFullItemMetas(LanguageCode.en),
      ]),
    );

    blocTest<ItemMetasBloc, ItemMetasState>(
      'emits ItemMetasLoadOnFailure when an error occurs.',
      setUp: () => when(
        () => localDatabaseApi.loadBaseItemMetas(LanguageCode.en),
      ).thenThrow(const UnknownException()),
      build: ItemMetasBloc.new,
      act: (bloc) => bloc.add(const ItemMetasInitializeEvent()),
      expect: () => const [ItemMetasLoadOnFailure()],
      verify: (_) {
        verify(
          () => localDatabaseApi.loadBaseItemMetas(LanguageCode.en),
        ).called(1);
        verifyNever(
          () => localDatabaseApi.loadFullItemMetas(LanguageCode.en),
        );
      },
    );
  });

  group('ItemMetasUpdateLanguageEvent', () {
    blocTest<ItemMetasBloc, ItemMetasState>(
      'emits ItemMetasLoadOnSuccess.',
      setUp: () {
        when(() => localDatabaseApi.loadBaseItemMetas(LanguageCode.en))
            .thenAnswer(
          (_) async => [],
        );
        when(() => localDatabaseApi.loadFullItemMetas(LanguageCode.en))
            .thenAnswer(
          (_) async => [],
        );
      },
      build: ItemMetasBloc.new,
      act: (bloc) =>
          bloc.add(const ItemMetasUpdateLanguageEvent(LanguageCode.en)),
      expect: () => const [
        ItemMetasLoadInProgress(),
        ItemMetasLoadOnSuccess([]),
      ],
      verify: (_) => verifyInOrder([
        () => localDatabaseApi.loadBaseItemMetas(LanguageCode.en),
        () => localDatabaseApi.loadFullItemMetas(LanguageCode.en),
      ]),
    );

    blocTest<ItemMetasBloc, ItemMetasState>(
      'emits ItemMetasLoadOnFailure when an error occurs.',
      setUp: () => when(
        () => localDatabaseApi.loadBaseItemMetas(LanguageCode.en),
      ).thenThrow(const UnknownException()),
      build: ItemMetasBloc.new,
      act: (bloc) =>
          bloc.add(const ItemMetasUpdateLanguageEvent(LanguageCode.en)),
      expect: () => const [
        ItemMetasLoadInProgress(),
        ItemMetasLoadOnFailure(),
      ],
      verify: (_) {
        verify(
          () => localDatabaseApi.loadBaseItemMetas(LanguageCode.en),
        ).called(1);
        verifyNever(
          () => localDatabaseApi.loadFullItemMetas(LanguageCode.en),
        );
      },
    );
  });
}
