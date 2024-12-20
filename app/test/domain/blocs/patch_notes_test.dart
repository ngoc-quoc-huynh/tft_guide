import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/patch_notes/bloc.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/patch_note.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final localDatabaseApi = MockLocalDatabaseApi();
  final createdAt = DateTime.utc(2024);

  setUpAll(
    () => Injector.instance
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<LocalDatabaseApi>()
      ..unregister<Translations>(),
  );

  test(
    'initial state is PatchNotesLoadInProgress.',
    () => expect(
      PatchNotesBloc(1).state,
      const PatchNotesLoadInProgress(),
    ),
  );

  group('PatchNotesInitializeEvent', () {
    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits PatchNotesLoadOnSuccess with lastPage is true.',
      setUp: () => when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => const PaginatedPatchNotes(
          patchNotes: [],
          totalPages: 1,
        ),
      ),
      build: () => PatchNotesBloc(1),
      act: (bloc) => bloc.add(const PatchNotesInitializeEvent()),
      expect: () => const [
        PatchNotesPaginationOnSuccess(
          currentPage: 0,
          patchNotes: [],
          isLastPage: true,
        ),
      ],
      verify: (_) => verify(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).called(1),
    );

    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits PatchNotesLoadOnSuccess with lastPage is false.',
      setUp: () => when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => PaginatedPatchNotes(
          patchNotes: [
            PatchNote(
              text: 'text',
              createdAt: createdAt,
            ),
          ],
          totalPages: 2,
        ),
      ),
      build: () => PatchNotesBloc(1),
      act: (bloc) => bloc.add(const PatchNotesInitializeEvent()),
      expect: () => [
        PatchNotesPaginationOnSuccess(
          currentPage: 0,
          patchNotes: [
            PatchNote(
              text: 'text',
              createdAt: createdAt,
            ),
          ],
          isLastPage: false,
        ),
      ],
      verify: (_) => verify(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).called(1),
    );

    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits PatchNotesLoadOnFailure when an error occurs.',
      setUp: () => when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenThrow(const UnknownException()),
      build: () => PatchNotesBloc(1),
      act: (bloc) => bloc.add(const PatchNotesInitializeEvent()),
      expect: () => const [PatchNotesLoadOnFailure()],
      verify: (_) => verify(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).called(1),
    );
  });

  group('PatchNotesLoadMoreEvent', () {
    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits PatchNotesLoadOnSuccess when lastPage was false.',
      setUp: () => when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 1,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => PaginatedPatchNotes(
          patchNotes: [
            PatchNote(
              text: 'text',
              createdAt: DateTime.utc(2023),
            ),
          ],
          totalPages: 2,
        ),
      ),
      build: () => PatchNotesBloc(1),
      seed: () => PatchNotesPaginationOnSuccess(
        currentPage: 0,
        patchNotes: [
          PatchNote(
            text: 'text',
            createdAt: createdAt,
          ),
        ],
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(const PatchNotesLoadMoreEvent()),
      expect: () => [
        PatchNotesPaginationInProgress(
          currentPage: 0,
          patchNotes: [
            PatchNote(
              text: 'text',
              createdAt: createdAt,
            ),
          ],
          isLastPage: false,
        ),
        PatchNotesPaginationOnSuccess(
          currentPage: 1,
          patchNotes: [
            PatchNote(
              text: 'text',
              createdAt: createdAt,
            ),
            PatchNote(
              text: 'text',
              createdAt: DateTime.utc(2023),
            ),
          ],
          isLastPage: true,
        ),
      ],
      verify: (_) => verify(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 1,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).called(1),
    );

    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits nothing when lastPage was true.',
      build: () => PatchNotesBloc(1),
      seed: () => PatchNotesPaginationOnSuccess(
        currentPage: 0,
        patchNotes: [
          PatchNote(
            text: 'text',
            createdAt: createdAt,
          ),
        ],
        isLastPage: true,
      ),
      act: (bloc) => bloc.add(const PatchNotesLoadMoreEvent()),
      expect: () => const <PatchNotesState>[],
      verify: (_) => verifyNever(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 1,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ),
    );

    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits PatchNotesPaginationOnFailure when an error occurs.',
      setUp: () => when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 1,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenThrow(const UnknownException()),
      build: () => PatchNotesBloc(1),
      seed: () => PatchNotesPaginationOnSuccess(
        currentPage: 0,
        patchNotes: [
          PatchNote(
            text: 'text',
            createdAt: createdAt,
          ),
        ],
        isLastPage: false,
      ),
      act: (bloc) => bloc.add(const PatchNotesLoadMoreEvent()),
      expect: () => [
        PatchNotesPaginationInProgress(
          currentPage: 0,
          patchNotes: [
            PatchNote(
              text: 'text',
              createdAt: createdAt,
            ),
          ],
          isLastPage: false,
        ),
        PatchNotesPaginationOnFailure(
          currentPage: 0,
          patchNotes: [
            PatchNote(
              text: 'text',
              createdAt: createdAt,
            ),
          ],
          isLastPage: false,
        ),
      ],
      verify: (_) => verify(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 1,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).called(1),
    );
  });

  group('PatchNotesChangeLocaleEvent', () {
    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits PatchNotesChangeLocaleOnSuccess.',
      setUp: () => when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => const PaginatedPatchNotes(
          patchNotes: [],
          totalPages: 1,
        ),
      ),
      build: () => PatchNotesBloc(1),
      act: (bloc) =>
          bloc.add(const PatchNotesChangeLanguageEvent(LanguageCode.en)),
      expect: () => const [
        PatchNotesChangeLocaleOnSuccess(
          currentPage: 0,
          patchNotes: [],
          isLastPage: true,
        ),
      ],
      verify: (_) => verify(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).called(1),
    );

    blocTest<PatchNotesBloc, PatchNotesState>(
      'emits PatchNotesLoadOnFailure when an error occurs.',
      setUp: () => when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).thenThrow(const UnknownException()),
      build: () => PatchNotesBloc(1),
      act: (bloc) =>
          bloc.add(const PatchNotesChangeLanguageEvent(LanguageCode.en)),
      expect: () => const [
        PatchNotesLoadOnFailure(),
      ],
      verify: (_) => verify(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: 1,
          languageCode: LanguageCode.en,
        ),
      ).called(1),
    );
  });
}
