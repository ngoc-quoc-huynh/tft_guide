import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/patch_notes_unread_counter/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/local_storage.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final localDatabaseApi = MockLocalDatabaseApi();
  final localStorageApi = MockLocalStorageApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<LocalStorageApi>(localStorageApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<LocalDatabaseApi>()
      ..unregister<LocalStorageApi>(),
  );

  test(
    'initial state is PatchNotesUnreadCounterLoadInProgress.',
    () => expect(
      PatchNotesUnreadCounterBloc().state,
      const PatchNotesUnreadCounterLoadInProgress(),
    ),
  );

  group('PatchNotesUnreadCounterInitializeEvent', () {
    blocTest<PatchNotesUnreadCounterBloc, PatchNotesUnreadCounterState>(
      'emits PatchNotesUnreadCounterLoadOnSuccess.',
      setUp: () {
        when(localDatabaseApi.loadPatchNotesCount).thenAnswer((_) async => 1);
        when(() => localStorageApi.readPatchNotesCount).thenReturn(0);
      },
      build: PatchNotesUnreadCounterBloc.new,
      act: (bloc) => bloc.add(const PatchNotesUnreadCounterInitializeEvent()),
      expect: () => [
        const PatchNotesUnreadCounterLoadOnSuccess(
          unreadCount: 1,
          totalCount: 1,
        ),
      ],
      verify: (_) => verifyInOrder([
        localDatabaseApi.loadPatchNotesCount,
        () => localStorageApi.readPatchNotesCount,
      ]),
    );

    blocTest<PatchNotesUnreadCounterBloc, PatchNotesUnreadCounterState>(
      'emits PatchNotesUnreadCounterLoadOnSuccess when an error occurs.',
      setUp: () => when(localDatabaseApi.loadPatchNotesCount)
          .thenThrow(const UnknownException()),
      build: PatchNotesUnreadCounterBloc.new,
      act: (bloc) => bloc.add(const PatchNotesUnreadCounterInitializeEvent()),
      expect: () => [
        const PatchNotesUnreadCounterLoadOnSuccess(
          unreadCount: 0,
          totalCount: 0,
        ),
      ],
      verify: (_) {
        verify(
          localDatabaseApi.loadPatchNotesCount,
        ).called(1);
        verifyNever(() => localStorageApi.readPatchNotesCount);
      },
    );
  });

  group('PatchNotesUnreadCounterReadEvent', () {
    blocTest<PatchNotesUnreadCounterBloc, PatchNotesUnreadCounterState>(
      'emits PatchNotesUnreadCounterLoadOnSuccess.',
      setUp: () =>
          when(() => localStorageApi.updateReadPatchNotesCount(1)).thenAnswer(
        (_) => Future.value(),
      ),
      seed: () => const PatchNotesUnreadCounterLoadOnSuccess(
        unreadCount: 1,
        totalCount: 1,
      ),
      build: PatchNotesUnreadCounterBloc.new,
      act: (bloc) => bloc.add(const PatchNotesUnreadCounterReadEvent()),
      expect: () => [
        const PatchNotesUnreadCounterLoadOnSuccess(
          unreadCount: 0,
          totalCount: 1,
        ),
      ],
      verify: (_) => verify(
        () => localStorageApi.updateReadPatchNotesCount(1),
      ).called(1),
    );

    blocTest<PatchNotesUnreadCounterBloc, PatchNotesUnreadCounterState>(
      'emits nothing when an error occurs.',
      setUp: () =>
          when(() => localStorageApi.updateReadPatchNotesCount(1)).thenThrow(
        const UnknownException(),
      ),
      seed: () => const PatchNotesUnreadCounterLoadOnSuccess(
        unreadCount: 1,
        totalCount: 1,
      ),
      build: PatchNotesUnreadCounterBloc.new,
      act: (bloc) => bloc.add(const PatchNotesUnreadCounterReadEvent()),
      expect: () => const <PatchNotesUnreadCounterState>[],
      verify: (_) => verify(() => localStorageApi.updateReadPatchNotesCount(1)),
    );

    blocTest<PatchNotesUnreadCounterBloc, PatchNotesUnreadCounterState>(
      'emits nothing when unreadCount is 0.',
      seed: () => const PatchNotesUnreadCounterLoadOnSuccess(
        unreadCount: 0,
        totalCount: 1,
      ),
      build: PatchNotesUnreadCounterBloc.new,
      act: (bloc) => bloc.add(const PatchNotesUnreadCounterReadEvent()),
      expect: () => const <PatchNotesUnreadCounterState>[],
      verify: (_) =>
          verifyNever(() => localStorageApi.updateReadPatchNotesCount(1)),
    );
  });
}
