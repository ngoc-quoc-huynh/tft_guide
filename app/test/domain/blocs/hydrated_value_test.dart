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
        // ignore: avoid-dynamic, since it is the method signature.
        () => storage.write(any(), any<dynamic>()),
      ).thenAnswer((_) => Future.value());
      HydratedBloc.storage = storage;
    },
  );

  tearDownAll(() => HydratedBloc.storage = null);

  group('HydratedEloCubit', () {
    test(
      'initial state is ThemeMode.system.',
      () => expect(
        HydratedEloCubit().state,
        0,
      ),
    );

    group('update', () {
      blocTest<HydratedEloCubit, int>(
        'emits new state.',
        build: HydratedEloCubit.new,
        act: (cubit) => cubit.update(10),
        expect: () => [10],
      );
    });

    group('increase', () {
      blocTest<HydratedEloCubit, int>(
        'emits increased state.',
        build: HydratedEloCubit.new,
        act: (cubit) => cubit.increase(1),
        expect: () => [1],
      );
    });

    group('reset', () {
      blocTest<HydratedEloCubit, int>(
        'emits 0.',
        build: HydratedEloCubit.new,
        act: (cubit) => cubit.reset(),
        expect: () => [0],
      );
    });

    group('fromJson', () {
      test('returns correctly.', () {
        final result = HydratedEloCubit().fromJson(
          {'elo': 0},
        );
        expect(result, 0);
      });
    });

    group('toJson', () {
      test('returns correctly.', () {
        final result = HydratedThemeModeCubit().toJson(ThemeMode.system);
        expect(result, {'theme_mode': 'system'});
      });
    });
  });

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
