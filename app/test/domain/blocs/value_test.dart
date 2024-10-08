import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';

void main() {
  group('ValueCubit', () {
    group(
      'BoolValueCubit',
      () {
        test(
          'initial state is false.',
          () => expect(
            BoolValueCubit(false).state,
            false,
          ),
        );

        blocTest<BoolValueCubit, bool>(
          'emits new state.',
          build: () => BoolValueCubit(false),
          act: (cubit) => cubit.update(true),
          expect: () => [true],
        );
      },
    );

    group(
      'NavigationBarValueCubit',
      () {
        test(
          'initial state is NavigationBarState.ranked.',
          () => expect(
            NavigationBarValueCubit(NavigationBarState.ranked).state,
            NavigationBarState.ranked,
          ),
        );

        blocTest<NavigationBarValueCubit, NavigationBarState>(
          'emits new state.',
          build: () => NavigationBarValueCubit(NavigationBarState.ranked),
          act: (cubit) => cubit.update(NavigationBarState.itemMetas),
          expect: () => [NavigationBarState.itemMetas],
        );
      },
    );

    group(
      'LanguageCodeValueCubit',
      () {
        tearDown(
          () async => Injector.instance.unregister<Translations>(),
        );

        test(
          'initial state is LanguageCode.en.',
          () {
            expect(
              LanguageCodeValueCubit(LanguageCode.en).state,
              LanguageCode.en,
            );
            expect(
              Injector.instance.isRegistered<TranslationsEn>(),
              isTrue,
            );
          },
        );

        blocTest<LanguageCodeValueCubit, LanguageCode>(
          'emits new state.',
          build: () => LanguageCodeValueCubit(LanguageCode.en),
          act: (cubit) => cubit.update(LanguageCode.de),
          expect: () => [LanguageCode.de],
        );
      },
    );

    group('NavigationBarValueCubit', () {
      test(
        'initial state is NavigationBarState.ranked.',
        () => expect(
          NavigationBarValueCubit(NavigationBarState.ranked).state,
          NavigationBarState.ranked,
        ),
      );

      group('update', () {
        blocTest<NavigationBarValueCubit, NavigationBarState>(
          'emits new state.',
          build: () => NavigationBarValueCubit(NavigationBarState.ranked),
          act: (cubit) => cubit.update(NavigationBarState.itemMetas),
          expect: () => [NavigationBarState.itemMetas],
        );
      });
    });

    group('ThemeModeValueCubit', () {
      test(
        'initial state is ThemeMode.system.',
        () => expect(
          ThemeModeValueCubit(ThemeMode.system).state,
          ThemeMode.system,
        ),
      );

      group('update', () {
        blocTest<ThemeModeValueCubit, ThemeMode>(
          'emits new state.',
          build: () => ThemeModeValueCubit(ThemeMode.system),
          act: (cubit) => cubit.update(ThemeMode.dark),
          expect: () => [ThemeMode.dark],
        );
      });
    });

    group('TranslationLocaleValueCubit', () {
      test(
        'initial state is TranslationLocale.system.',
        () => expect(
          TranslationLocaleValueCubit(TranslationLocale.system).state,
          TranslationLocale.system,
        ),
      );

      group('update', () {
        blocTest<TranslationLocaleValueCubit, TranslationLocale>(
          'emits new state.',
          build: () => TranslationLocaleValueCubit(TranslationLocale.system),
          act: (cubit) => cubit.update(TranslationLocale.english),
          expect: () => [TranslationLocale.english],
        );
      });
    });

    group('ThemeModeValueCubit', () {
      test(
        'initial state is ThemeMode.system.',
        () => expect(
          ThemeModeValueCubit(ThemeMode.system).state,
          ThemeMode.system,
        ),
      );

      group('update', () {
        blocTest<ThemeModeValueCubit, ThemeMode>(
          'emits new state.',
          build: () => ThemeModeValueCubit(ThemeMode.system),
          act: (cubit) => cubit.update(ThemeMode.dark),
          expect: () => [ThemeMode.dark],
        );
      });
    });
  });

  group('NumValueCubit', () {
    group('IntValueCubit', () {
      test(
        'initial state is 0.',
        () => expect(IntValueCubit(0).state, 0),
      );

      group('increase', () {
        blocTest<IntValueCubit, int>(
          'emits increased state.',
          build: () => IntValueCubit(0),
          act: (cubit) => cubit.increase(),
          expect: () => [1],
        );
      });

      group('update', () {
        blocTest<IntValueCubit, int>(
          'emits new state.',
          build: () => IntValueCubit(0),
          act: (cubit) => cubit.update(10),
          expect: () => [10],
        );
      });
    });

    group('NullableIntValueCubit', () {
      test(
        'initial state is null.',
        () => expect(NullableIntValueCubit(null).state, isNull),
      );

      group('increase', () {
        blocTest<NullableIntValueCubit, int?>(
          'emits 1 when state is null.',
          build: () => NullableIntValueCubit(null),
          act: (cubit) => cubit.increase(),
          expect: () => [1],
        );

        blocTest<NullableIntValueCubit, int?>(
          'emits increased state.',
          build: () => NullableIntValueCubit(0),
          act: (cubit) => cubit.increase(),
          expect: () => [1],
        );
      });

      group('update', () {
        blocTest<NullableIntValueCubit, int?>(
          'emits new state.',
          build: () => NullableIntValueCubit(null),
          act: (cubit) => cubit.update(10),
          expect: () => [10],
        );
      });
    });
  });

  group('SelectionValueCubit', () {
    group('SelectedItemOptionValueCubit', () {
      const option = QuestionBaseItemOption(
        id: 'id',
        name: 'name',
        description: 'description',
      );

      test(
        'initial state is null.',
        () => expect(
          SelectedItemOptionValueCubit().state,
          isNull,
        ),
      );

      group('select', () {
        blocTest<SelectedItemOptionValueCubit, QuestionItemOption?>(
          'emits new option.',
          build: SelectedItemOptionValueCubit.new,
          act: (cubit) => cubit.select(option),
          expect: () => [option],
        );

        blocTest<SelectedItemOptionValueCubit, QuestionItemOption?>(
          'emits null when option is selected.',
          build: SelectedItemOptionValueCubit.new,
          seed: () => option,
          act: (cubit) => cubit.select(option),
          expect: () => [null],
        );
      });
    });
  });
}
