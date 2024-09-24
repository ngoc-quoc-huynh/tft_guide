import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final storage = MockStorage();

  setUpAll(
    () {
      when(
        () => storage.write(any(), any<dynamic>()),
      ).thenAnswer((_) => Future.value());
      HydratedBloc.storage = storage;
    },
  );

  group('HydratedThemeModeCubit', () {
    test(
      'initial state is ThemeMode.system.',
      () => expect(
        HydratedThemeModeCubit().state,
        ThemeMode.system,
      ),
    );

    group('update', () {
      blocTest<HydratedThemeModeCubit, ThemeMode>(
        'emits new state.',
        build: HydratedThemeModeCubit.new,
        act: (cubit) => cubit.update(ThemeMode.dark),
        expect: () => [ThemeMode.dark],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = HydratedThemeModeCubit().fromJson(
          {'theme_mode': 'system'},
        );
        expect(result, ThemeMode.system);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = HydratedThemeModeCubit().toJson(ThemeMode.system);
        expect(result, {'theme_mode': 'system'});
      });
    });
  });

  group('HydratedTranslationLocaleCubit', () {
    test(
      'initial state is TranslationLocale.system.',
      () => expect(
        HydratedTranslationLocaleCubit().state,
        TranslationLocale.system,
      ),
    );

    group('update', () {
      blocTest<HydratedTranslationLocaleCubit, TranslationLocale>(
        'emits new state.',
        build: HydratedTranslationLocaleCubit.new,
        act: (cubit) => cubit.update(TranslationLocale.english),
        expect: () => [TranslationLocale.english],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = HydratedTranslationLocaleCubit().fromJson(
          {'language': 'system'},
        );
        expect(result, TranslationLocale.system);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = HydratedTranslationLocaleCubit().toJson(
          TranslationLocale.system,
        );
        expect(result, {'language': 'system'});
      });
    });
  });
}
