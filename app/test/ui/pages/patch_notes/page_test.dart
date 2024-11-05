import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/domain/interfaces/local_database.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/patch_note.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/patch_notes/page.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final localDatabaseApi = MockLocalDatabaseApi();
  const pageSize = 1;
  setUpAll(
    () => Injector.instance
      ..registerSingleton<LocalDatabaseApi>(localDatabaseApi)
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<int>(pageSize, instanceName: 'patchNotesPageSize'),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<LocalDatabaseApi>()
      ..unregister<Translations>()
      ..unregister<int>(instanceName: 'patchNotesPageSize'),
  );

  final languageCodeCubit = MockLanguageCodeValueCubit();
  whenListen<LanguageCode>(
    languageCodeCubit,
    const Stream<LanguageCode>.empty(),
    initialState: LanguageCode.en,
  );

  await goldenTest(
    'renders empty correctly.',
    fileName: 'page_empty',
    constraints: pageConstraints(),
    builder: () {
      when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: pageSize,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => const PaginatedPatchNotes(
          patchNotes: [],
          totalPages: 1,
        ),
      );

      return _TestWidget(languageCodeCubit);
    },
  );

  await goldenTest(
    'renders filled correctly.',
    fileName: 'page_filled',
    constraints: pageConstraints(),
    builder: () {
      when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: pageSize,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => PaginatedPatchNotes(
          patchNotes: [
            PatchNote(
              createdAt: DateTime(2024),
              text: '- Initial release',
            ),
          ],
          totalPages: 1,
        ),
      );

      return _TestWidget(languageCodeCubit);
    },
  );

  await goldenTest(
    'renders loading more correctly.',
    fileName: 'page_loading_more',
    constraints: pageConstraints(),
    pumpBeforeTest: (tester) async {
      await tester.pump();
    },
    whilePerforming: (tester) async {
      await tester.pump(const Duration(milliseconds: 200));
      return null;
    },
    builder: () {
      when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: pageSize,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => PaginatedPatchNotes(
          patchNotes: [
            PatchNote(
              createdAt: DateTime(2024),
              text: '- Initial release',
            ),
          ],
          totalPages: 2,
        ),
      );
      when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 1,
          pageSize: pageSize,
          languageCode: LanguageCode.en,
        ),
      ).thenAnswer(
        (_) async => PaginatedPatchNotes(
          patchNotes: [
            PatchNote(
              createdAt: DateTime(2025),
              text: '- Fix bug',
            ),
          ],
          totalPages: 2,
        ),
      );

      return _TestWidget(languageCodeCubit);
    },
  );

  await goldenTest(
    'renders error correctly.',
    fileName: 'page_error',
    constraints: pageConstraints(),
    builder: () {
      when(
        () => localDatabaseApi.loadPatchNotes(
          currentPage: 0,
          pageSize: pageSize,
          languageCode: LanguageCode.en,
        ),
      ).thenThrow(const UnknownException());

      return _TestWidget(languageCodeCubit);
    },
  );
}

class _TestWidget extends StatelessWidget {
  const _TestWidget(this.languageCodeCubit);

  final LanguageCodeValueCubit languageCodeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCodeValueCubit>.value(
      value: languageCodeCubit,
      child: const PatchNotesPage(),
    );
  }
}
