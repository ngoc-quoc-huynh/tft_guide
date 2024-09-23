import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/domain/exceptions/remote_database.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/interfaces/remote_database.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  final remoteDatabaseApi = MockRemoteDatabaseApi();

  setUpAll(
    () => Injector.instance
        .registerSingleton<RemoteDatabaseApi>(remoteDatabaseApi),
  );

  tearDownAll(
    () async => Injector.instance.unregister<RemoteDatabaseApi>(),
  );

  group('CheckAssetsBloc', () {
    final fileStorageApi = MockFileStorageApi();

    setUpAll(
      () => Injector.instance.registerSingleton<FileStorageApi>(fileStorageApi),
    );

    tearDownAll(
      () async => Injector.instance.unregister<FileStorageApi>(),
    );

    test(
      'initial state is CheckDataInitial.',
      () => expect(
        CheckAssetsBloc().state,
        equals(const CheckDataInitial()),
      ),
    );

    group('CheckDataStartEvent', () {
      blocTest<CheckAssetsBloc, CheckDataState>(
        'emits CheckAssetsLoadOnValid when local count and remote count are '
        'equal.',
        setUp: () {
          when(fileStorageApi.loadAssetsCount).thenReturn(0);
          when(remoteDatabaseApi.loadAssetsCount).thenAnswer((_) async => 0);
        },
        build: CheckAssetsBloc.new,
        act: (bloc) => bloc.add(const CheckDataStartEvent()),
        expect: () => const [
          CheckDataLoadInProgress(),
          CheckAssetsLoadOnValid(
            localCount: 0,
            remoteCount: 0,
          ),
        ],
        verify: (_) => verifyInOrder([
          fileStorageApi.loadAssetsCount,
          remoteDatabaseApi.loadAssetsCount,
        ]),
      );

      blocTest<CheckAssetsBloc, CheckDataState>(
        'emits CheckAssetsLoadOnInvalid when local count and remote count are '
        'different.',
        setUp: () {
          when(fileStorageApi.loadAssetsCount).thenReturn(0);
          when(remoteDatabaseApi.loadAssetsCount).thenAnswer((_) async => 1);
        },
        build: CheckAssetsBloc.new,
        act: (bloc) => bloc.add(const CheckDataStartEvent()),
        expect: () => const [
          CheckDataLoadInProgress(),
          CheckAssetsLoadOnInvalid(
            localCount: 0,
            remoteCount: 1,
          ),
        ],
        verify: (_) => verifyInOrder([
          fileStorageApi.loadAssetsCount,
          remoteDatabaseApi.loadAssetsCount,
        ]),
      );

      blocTest<CheckAssetsBloc, CheckDataState>(
        'emits CheckDataLoadOnFailure when an error occurs.',
        setUp: () {
          when(fileStorageApi.loadAssetsCount).thenReturn(0);
          when(remoteDatabaseApi.loadAssetsCount)
              .thenThrow(const NoConnectionException());
        },
        build: CheckAssetsBloc.new,
        act: (bloc) => bloc.add(const CheckDataStartEvent()),
        expect: () => const [
          CheckDataLoadInProgress(),
          CheckDataLoadOnFailure(),
        ],
        verify: (_) => verifyInOrder([
          fileStorageApi.loadAssetsCount,
          remoteDatabaseApi.loadAssetsCount,
        ]),
      );
    });
  });

  group('CheckDatabaseBloc', () {
    final localDatabaseApi = MockLocalDatabaseApi();

    setUpAll(
      () => Injector.instance
          .registerSingleton<LocalDatabaseApi>(localDatabaseApi),
    );

    tearDownAll(
      () async => Injector.instance.unregister<LocalDatabaseApi>(),
    );

    group('CheckBaseItemsBloc', () {
      test('initial state is CheckDataInitial.', () {
        expect(
          CheckBaseItemsBloc().state,
          equals(const CheckDataInitial()),
        );
      });

      group('CheckDataStartEvent', () {
        blocTest<CheckBaseItemsBloc, CheckDataState>(
          'emits CheckDatabaseLoadOnValid when local counts and remote counts '
          'are equal.',
          setUp: () {
            when(localDatabaseApi.loadBaseItemsCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadBaseItemsCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadBaseItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadBaseItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
          },
          build: CheckBaseItemsBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDatabaseLoadOnValid(
              localDataCount: 0,
              remoteDataCount: 0,
              localTranslationCount: 0,
              remoteTranslationCount: 0,
            ),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadBaseItemsCount,
            remoteDatabaseApi.loadBaseItemsCount,
            localDatabaseApi.loadBaseItemTranslationsCount,
            remoteDatabaseApi.loadBaseItemTranslationsCount,
          ]),
        );

        blocTest<CheckBaseItemsBloc, CheckDataState>(
          'emits CheckDatabaseLoadOnInvalid when local counts and remote counts'
          ' are different.',
          setUp: () {
            when(localDatabaseApi.loadBaseItemsCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadBaseItemsCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadBaseItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadBaseItemTranslationsCount).thenAnswer(
              (_) async => 1,
            );
          },
          build: CheckBaseItemsBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDatabaseLoadOnInvalid(
              localDataCount: 0,
              remoteDataCount: 0,
              localTranslationCount: 0,
              remoteTranslationCount: 1,
            ),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadBaseItemsCount,
            remoteDatabaseApi.loadBaseItemsCount,
            localDatabaseApi.loadBaseItemTranslationsCount,
            remoteDatabaseApi.loadBaseItemTranslationsCount,
          ]),
        );

        blocTest<CheckBaseItemsBloc, CheckDataState>(
          'emits CheckDataLoadOnFailure when an error occurs.',
          setUp: () {
            when(localDatabaseApi.loadBaseItemsCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadBaseItemsCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadBaseItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadBaseItemTranslationsCount).thenThrow(
              const NoConnectionException(),
            );
          },
          build: CheckBaseItemsBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDataLoadOnFailure(),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadBaseItemsCount,
            remoteDatabaseApi.loadBaseItemsCount,
            localDatabaseApi.loadBaseItemTranslationsCount,
            remoteDatabaseApi.loadBaseItemTranslationsCount,
          ]),
        );
      });
    });

    group('CheckFullItemsBloc', () {
      test('initial state is CheckDataInitial.', () {
        expect(
          CheckFullItemsBloc().state,
          equals(const CheckDataInitial()),
        );
      });

      group('CheckDataStartEvent', () {
        blocTest<CheckFullItemsBloc, CheckDataState>(
          'emits CheckDatabaseLoadOnValid local counts and remote counts are'
          ' equal.',
          setUp: () {
            when(localDatabaseApi.loadFullItemsCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadFullItemsCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadFullItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadFullItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
          },
          build: CheckFullItemsBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDatabaseLoadOnValid(
              localDataCount: 0,
              remoteDataCount: 0,
              localTranslationCount: 0,
              remoteTranslationCount: 0,
            ),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadFullItemsCount,
            remoteDatabaseApi.loadFullItemsCount,
            localDatabaseApi.loadFullItemTranslationsCount,
            remoteDatabaseApi.loadFullItemTranslationsCount,
          ]),
        );

        blocTest<CheckFullItemsBloc, CheckDataState>(
          'emits CheckDatabaseLoadOnInvalid when local counts and remote counts'
          ' are different.',
          setUp: () {
            when(localDatabaseApi.loadFullItemsCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadFullItemsCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadFullItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadFullItemTranslationsCount).thenAnswer(
              (_) async => 1,
            );
          },
          build: CheckFullItemsBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDatabaseLoadOnInvalid(
              localDataCount: 0,
              remoteDataCount: 0,
              localTranslationCount: 0,
              remoteTranslationCount: 1,
            ),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadFullItemsCount,
            remoteDatabaseApi.loadFullItemsCount,
            localDatabaseApi.loadFullItemTranslationsCount,
            remoteDatabaseApi.loadFullItemTranslationsCount,
          ]),
        );

        blocTest<CheckFullItemsBloc, CheckDataState>(
          'emits CheckDataLoadOnFailure when an error occurs.',
          setUp: () {
            when(localDatabaseApi.loadFullItemsCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadFullItemsCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadFullItemTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadFullItemTranslationsCount).thenThrow(
              const NoConnectionException(),
            );
          },
          build: CheckFullItemsBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDataLoadOnFailure(),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadFullItemsCount,
            remoteDatabaseApi.loadFullItemsCount,
            localDatabaseApi.loadFullItemTranslationsCount,
            remoteDatabaseApi.loadFullItemTranslationsCount,
          ]),
        );
      });
    });

    group('CheckPatchNotesBloc', () {
      test('initial state is CheckDataInitial.', () {
        expect(
          CheckPatchNotesBloc().state,
          equals(const CheckDataInitial()),
        );
      });

      group('CheckDataStartEvent', () {
        blocTest<CheckPatchNotesBloc, CheckDataState>(
          'emits CheckDatabaseLoadOnValid when local counts and remote counts '
          'are equal.',
          setUp: () {
            when(localDatabaseApi.loadPatchNotesCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadPatchNotesCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadPatchNoteTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadPatchNoteTranslationsCount).thenAnswer(
              (_) async => 0,
            );
          },
          build: CheckPatchNotesBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDatabaseLoadOnValid(
              localDataCount: 0,
              remoteDataCount: 0,
              localTranslationCount: 0,
              remoteTranslationCount: 0,
            ),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadPatchNotesCount,
            remoteDatabaseApi.loadPatchNotesCount,
            localDatabaseApi.loadPatchNoteTranslationsCount,
            remoteDatabaseApi.loadPatchNoteTranslationsCount,
          ]),
        );

        blocTest<CheckPatchNotesBloc, CheckDataState>(
          'emits CheckDatabaseLoadOnInvalid when local counts and remote counts'
          ' are different.',
          setUp: () {
            when(localDatabaseApi.loadPatchNotesCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadPatchNotesCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadPatchNoteTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadPatchNoteTranslationsCount).thenAnswer(
              (_) async => 1,
            );
          },
          build: CheckPatchNotesBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDatabaseLoadOnInvalid(
              localDataCount: 0,
              remoteDataCount: 0,
              localTranslationCount: 0,
              remoteTranslationCount: 1,
            ),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadPatchNotesCount,
            remoteDatabaseApi.loadPatchNotesCount,
            localDatabaseApi.loadPatchNoteTranslationsCount,
            remoteDatabaseApi.loadPatchNoteTranslationsCount,
          ]),
        );

        blocTest<CheckPatchNotesBloc, CheckDataState>(
          'emits CheckDataLoadOnFailure when an error occurs.',
          setUp: () {
            when(localDatabaseApi.loadPatchNotesCount)
                .thenAnswer((_) async => 0);
            when(remoteDatabaseApi.loadPatchNotesCount)
                .thenAnswer((_) async => 0);
            when(localDatabaseApi.loadPatchNoteTranslationsCount).thenAnswer(
              (_) async => 0,
            );
            when(remoteDatabaseApi.loadPatchNoteTranslationsCount).thenThrow(
              const NoConnectionException(),
            );
          },
          build: CheckPatchNotesBloc.new,
          act: (bloc) => bloc.add(const CheckDataStartEvent()),
          expect: () => const [
            CheckDataLoadInProgress(),
            CheckDataLoadOnFailure(),
          ],
          verify: (_) => verifyInOrder([
            localDatabaseApi.loadPatchNotesCount,
            remoteDatabaseApi.loadPatchNotesCount,
            localDatabaseApi.loadPatchNoteTranslationsCount,
            remoteDatabaseApi.loadPatchNoteTranslationsCount,
          ]),
        );
      });
    });
  });
}
